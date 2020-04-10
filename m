Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B250C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312CB208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 13:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Llqlp1+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312CB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMtHr-0001ao-Cb
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 09:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMtGf-0000Xb-0K
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMtGc-0002ut-Pn
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:00:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMtGc-0002tX-KV
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 09:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586523617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCx8TRCab2EyE5b6JCtf3fOgKYBHngg3c3wKI9dd41w=;
 b=Llqlp1+jNZVxZDouHDptPQsKhgn9qm4Pq0JwpyR0ulbdxShkSC+dFKKsHwZzg/x7p/Lp3f
 pectlSQN+5hmDH+arjKnS3sPQAs95Wjr3WtyPqF+NcPn5wKk6KA+LxGuo3RlE4QgTLZtPO
 3KoAQnxtd0c3YfAT1+nFQzRI/8icyp0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Nu-HFLFgOb-EbvURAQjdkw-1; Fri, 10 Apr 2020 09:00:12 -0400
X-MC-Unique: Nu-HFLFgOb-EbvURAQjdkw-1
Received: by mail-ed1-f69.google.com with SMTP id c2so2004890edx.16
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 06:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=veSmJyZuXpZswsn2rf+jN9UgYjF7Pu7CwRcQFPhcs50=;
 b=GrKhX+WHZThCbxNqau1irdf9r2SJz06L0RbYJX/zHI/lIWzMLx9cjaUexIrRLd/pCd
 YuHDxSew8LsGsC58siRvwVJy2OFiihGHlnawgdLqR5bO59OswFd92YyQfx8SiVa7lV8i
 Yskm9H8Yf9BJoQ4v68nErRQX1MEGIKPAvx0Bw77S7qZ6BnlPd9Ul2+uPrNmkJZ91Nout
 bd2rjaFy7eHXuqDtGJdVBibs7VNFrTvWvHvRG8wQTzlpWJrVK34nxo2R8tYFHH8hWzZz
 7N7b8lTbQkIZcwWasZwzl7CLaRHMnPunbmYHIeIFHPyv/saLgmIGA/0IzGHccRdsnegb
 1vvQ==
X-Gm-Message-State: AGi0PuaUhH/0FiLJdyzFGtaXAanF05fShFm6gG1r558fTeqrw3Uu5vqM
 Yrzc+jQN4mrMsjtrEqld0yooJvFLe6SajskJSsX7GxBADerqLHdk2hXhmvPX8EGcfQT6+qcYX2o
 HFaEOd6w+ZGRKN/g=
X-Received: by 2002:a50:8e1c:: with SMTP id 28mr4707576edw.199.1586523610175; 
 Fri, 10 Apr 2020 06:00:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypJKDnRI7jlrlibMlF1sFMWF5XpnPaHVsZCksIh7b0XNNKxGH1NQ06rIzeWnwf8WVg+iRCDZjw==
X-Received: by 2002:a50:8e1c:: with SMTP id 28mr4707531edw.199.1586523609831; 
 Fri, 10 Apr 2020 06:00:09 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id e4sm116613eje.45.2020.04.10.06.00.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 06:00:09 -0700 (PDT)
Subject: Re: [PATCH v2] Makefile: libfdt: build only the strict necessary
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200409124337.32134-1-cfontana@suse.de>
 <2a5ea4be-96bb-b686-1683-52269bd518ff@redhat.com>
Message-ID: <c9c407e4-9f90-44e9-d8f9-3a9681456057@redhat.com>
Date: Fri, 10 Apr 2020 15:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2a5ea4be-96bb-b686-1683-52269bd518ff@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Bennee <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 6:33 PM, Philippe Mathieu-Daud=E9 wrote:
> Hi Claudio,
>=20
> On 4/9/20 2:43 PM, Claudio Fontana wrote:
>> when building dtc/libfdt, we were previously using dtc/Makefile,
>> which tries to build some artifacts that are not needed,
>> and can complain on stderr about the absence of tools that
>> are not required to build just libfdt.
>>
>> Instead, build only the strict necessary to get libfdt.a .
>>
>> Remove the subdir-dtc "compatibility gunk" for recursion,
>> since we are not recursing anymore.
>>
>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>> ---
>> =A0 Makefile=A0 | 23 +++++++++++++----------
>> =A0 configure |=A0 6 +-----
>> =A0 rules.mak |=A0 2 ++
>> =A0 3 files changed, 16 insertions(+), 15 deletions(-)
>>
>> v1 -> v2:
>>
>> * fix error generated when running UNCHECKED_GOALS without prior=20
>> configure,
>> =A0=A0 for example during make docker-image-fedora. Without configure,=
=20
>> DSOSUF is
>> =A0=A0 empty, and the module pattern rule in rules.mak that uses this=20
>> variable
>> =A0=A0 can match too much; provide a default in the Makefile to avoid it=
.
>>
>> * only attempt to build the archive when there is a non-empty list of=20
>> objects.
>> =A0=A0 This could be done in general for the %.a: pattern in rules.mak,=
=20
>> but maybe
>> =A0=A0 there are valid reasons to build an empty .a?
>>
>> * removed some intermediate variables that did not add much value
>> =A0=A0 (LIBFDT_srcdir, LIBFDT_archive)
>>
>> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src=20
>> subdir),
>> and with docker-image-fedora, docker-test-debug@fedora that failed=20
>> before.
>>
>> diff --git a/Makefile b/Makefile
>> index 84ef881600..92bc853b5f 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -4,6 +4,10 @@ ifneq ($(words $(subst :, ,$(CURDIR))), 1)
>> =A0=A0=A0 $(error main directory cannot contain spaces nor colons)
>> =A0 endif
>> +# some pattern rules in rules.mak are confused by an empty DSOSUF,
>> +# and UNCHECKED_GOALS for testing (docker-) can run without prior=20
>> configure.
>> +DSOSUF ?=3D ".so"
>> +
>> =A0 # Always point to the root of the build tree (needs GNU make).
>> =A0 BUILD_DIR=3D$(CURDIR)
>> @@ -526,15 +530,16 @@ $(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
>> =A0 $(TARGET_DIRS_RULES):
>> =A0=A0=A0=A0=A0 $(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(di=
r $@)=20
>> V=3D"$(V)" TARGET_DIR=3D"$(dir $@)" $(notdir $@),)
>> -DTC_MAKE_ARGS=3D-I$(SRC_PATH)/dtc VPATH=3D$(SRC_PATH)/dtc -C dtc V=3D"$=
(V)"=20
>> LIBFDT_srcdir=3D$(SRC_PATH)/dtc/libfdt
>> -DTC_CFLAGS=3D$(CFLAGS) $(QEMU_CFLAGS)
>> -DTC_CPPFLAGS=3D-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc=20
>> -I$(SRC_PATH)/dtc/libfdt
>> -
>> -.PHONY: dtc/all
>> -dtc/all: .git-submodule-status dtc/libfdt dtc/tests
>=20
> I'm getting:
>=20
> config-host.mak is out-of-date, running configure
> make: *** No rule to make target 'dtc/all', needed by 'config-host.h'.=20
> Stop.
>=20
> On second try it works.

FYI same happens when going back (previous this patch applied) but there=20
is nothing we can do to prevent that afaik:

config-host.mak is out-of-date, running configure
make: *** No rule to make target 'libfdt', needed by 'config-host.h'.  Stop=
.

>=20
> Instead of alarming users, we could keep this target as a silent no-op,=
=20
> then remove it after some time.
>=20
> For the rest, patch looks good, nice cleanup!
>=20
> Regards,
>=20
> Phil.
>=20
>> -=A0=A0=A0 $(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS)=20
>> CPPFLAGS=3D"$(DTC_CPPFLAGS)" CFLAGS=3D"$(DTC_CFLAGS)"=20
>> LDFLAGS=3D"$(QEMU_LDFLAGS)" ARFLAGS=3D"$(ARFLAGS)" CC=3D"$(CC)" AR=3D"$(=
AR)"=20
>> LD=3D"$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
>> +LIBFDT_objdir =3D dtc/libfdt
>> +-include $(SRC_PATH)/dtc/libfdt/Makefile.libfdt
>> +LIBFDT_objects =3D $(addprefix $(LIBFDT_objdir)/, $(LIBFDT_OBJS))
>> +.PHONY: libfdt
>> +libfdt: .git-submodule-status $(LIBFDT_objdir)/libfdt.a
>> +$(LIBFDT_objdir)/libfdt.a: $(LIBFDT_objects)
>> +=A0=A0=A0 $(if $(LIBFDT_objects),$(call quiet-command,rm -f $@ && $(AR)=
 rcs=20
>> $@ $^,"AR","$(TARGET_DIR)$@"),)
>> -dtc/%: .git-submodule-status
>> +$(LIBFDT_objects): | $(LIBFDT_objdir)
>> +$(LIBFDT_objdir): .git-submodule-status
>> =A0=A0=A0=A0=A0 @mkdir -p $@
>> =A0 # Overriding CFLAGS causes us to lose defines added in the=20
>> sub-makefile.
>> @@ -563,7 +568,6 @@ slirp/all: .git-submodule-status
>> =A0 # Compatibility gunk to keep make working across the rename of targe=
ts
>> =A0 # for recursion, to be removed some time after 4.1.
>> -subdir-dtc: dtc/all
>> =A0 subdir-capstone: capstone/all
>> =A0 subdir-slirp: slirp/all
>> @@ -821,7 +825,6 @@ distclean: clean
>> =A0=A0=A0=A0=A0 rm -rf $$d || exit 1 ; \
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 done
>> =A0=A0=A0=A0=A0 rm -Rf .sdk
>> -=A0=A0=A0 if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS)=
=20
>> clean; fi
>> =A0 KEYMAPS=3Dda=A0=A0=A0=A0 en-gb=A0 et=A0 fr=A0=A0=A0=A0 fr-ch=A0 is=
=A0 lt=A0 no=A0 pt-br=A0 sv \
>> =A0 ar=A0=A0=A0=A0=A0 de=A0=A0=A0=A0 en-us=A0 fi=A0 fr-be=A0 hr=A0=A0=A0=
=A0 it=A0 lv=A0 nl=A0=A0=A0=A0=A0=A0=A0=A0 pl =20
>> ru=A0=A0=A0=A0 th \
>> diff --git a/configure b/configure
>> index 233c671aaa..36f83ffc5a 100755
>> --- a/configure
>> +++ b/configure
>> @@ -4278,10 +4278,6 @@ EOF
>> =A0=A0=A0=A0=A0=A0=A0 if test -d "${source_path}/dtc/libfdt" || test -e=
=20
>> "${source_path}/.git" ; then
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt=3Dgit
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mkdir -p dtc
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ "$pwd_is_source_path" !=3D "y" ] ; the=
n
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 symlink "$source_path/dtc/Makef=
ile" "dtc/Makefile"
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 symlink "$source_path/dtc/scrip=
ts" "dtc/scripts"
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt_cflags=3D"-I\$(SRC_PATH)/dtc/libfd=
t"
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt_ldflags=3D"-L\$(BUILD_DIR)/dtc/lib=
fdt"
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt_libs=3D"$fdt_libs"
>> @@ -8151,7 +8147,7 @@ echo "PIXMAN_CFLAGS=3D$pixman_cflags" >>=20
>> $config_host_mak
>> =A0 echo "PIXMAN_LIBS=3D$pixman_libs" >> $config_host_mak
>> =A0 if [ "$fdt" =3D "git" ]; then
>> -=A0 echo "config-host.h: dtc/all" >> $config_host_mak
>> +=A0 echo "config-host.h: libfdt" >> $config_host_mak
>> =A0 fi
>> =A0 if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
>> =A0=A0=A0 echo "config-host.h: capstone/all" >> $config_host_mak
>> diff --git a/rules.mak b/rules.mak
>> index 694865b63e..61eb474ba4 100644
>> --- a/rules.mak
>> +++ b/rules.mak
>> @@ -105,6 +105,8 @@ LINK =3D $(call quiet-command, $(LINKPROG) $(CFLAGS)=
=20
>> $(QEMU_LDFLAGS) -o $@ \
>> =A0 DSO_OBJ_CFLAGS :=3D -fPIC -DBUILD_DSO
>> =A0 module-common.o: CFLAGS +=3D $(DSO_OBJ_CFLAGS)
>> +
>> +# Note: DSOSUF must not be empty, or these rules will try to match=20
>> too much
>> =A0 %$(DSOSUF): QEMU_LDFLAGS +=3D $(LDFLAGS_SHARED)
>> =A0 %$(DSOSUF): %.mo
>> =A0=A0=A0=A0=A0 $(call LINK,$^)
>>


