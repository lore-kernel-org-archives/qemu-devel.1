Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B0C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:33:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA585206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA585206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMuiS-00085j-OQ
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cfontana@suse.de>) id 1jMuhV-00078r-9q
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cfontana@suse.de>) id 1jMuhT-00072g-Ec
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:32:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cfontana@suse.de>) id 1jMuhT-00070S-5q
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:32:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4FB92AD83;
 Fri, 10 Apr 2020 14:32:02 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2] Makefile: libfdt: build only the strict necessary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Markus Armbruster <armbru@redhat.com>
References: <20200409124337.32134-1-cfontana@suse.de>
 <2a5ea4be-96bb-b686-1683-52269bd518ff@redhat.com>
 <c9c407e4-9f90-44e9-d8f9-3a9681456057@redhat.com>
Message-ID: <98172eb5-2475-b3aa-6e1f-83830e9ee2c0@suse.de>
Date: Fri, 10 Apr 2020 16:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c9c407e4-9f90-44e9-d8f9-3a9681456057@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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

Hello Philippe, Markus,

On 4/10/20 3:00 PM, Philippe Mathieu-Daud=E9 wrote:
> On 4/9/20 6:33 PM, Philippe Mathieu-Daud=E9 wrote:
>> Hi Claudio,
>>
>> On 4/9/20 2:43 PM, Claudio Fontana wrote:
>>> when building dtc/libfdt, we were previously using dtc/Makefile,
>>> which tries to build some artifacts that are not needed,
>>> and can complain on stderr about the absence of tools that
>>> are not required to build just libfdt.
>>>
>>> Instead, build only the strict necessary to get libfdt.a .
>>>
>>> Remove the subdir-dtc "compatibility gunk" for recursion,
>>> since we are not recursing anymore.
>>>
>>> Signed-off-by: Claudio Fontana <cfontana@suse.de>
>>> ---
>>> =A0 Makefile=A0 | 23 +++++++++++++----------
>>> =A0 configure |=A0 6 +-----
>>> =A0 rules.mak |=A0 2 ++
>>> =A0 3 files changed, 16 insertions(+), 15 deletions(-)
>>>
>>> v1 -> v2:
>>>
>>> * fix error generated when running UNCHECKED_GOALS without prior=20
>>> configure,
>>> =A0=A0 for example during make docker-image-fedora. Without configure=
,=20
>>> DSOSUF is
>>> =A0=A0 empty, and the module pattern rule in rules.mak that uses this=
=20
>>> variable
>>> =A0=A0 can match too much; provide a default in the Makefile to avoid=
 it.
>>>
>>> * only attempt to build the archive when there is a non-empty list of=
=20
>>> objects.
>>> =A0=A0 This could be done in general for the %.a: pattern in rules.ma=
k,=20
>>> but maybe
>>> =A0=A0 there are valid reasons to build an empty .a?
>>>
>>> * removed some intermediate variables that did not add much value
>>> =A0=A0 (LIBFDT_srcdir, LIBFDT_archive)
>>>
>>> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src=20
>>> subdir),
>>> and with docker-image-fedora, docker-test-debug@fedora that failed=20
>>> before.
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 84ef881600..92bc853b5f 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -4,6 +4,10 @@ ifneq ($(words $(subst :, ,$(CURDIR))), 1)
>>> =A0=A0=A0 $(error main directory cannot contain spaces nor colons)
>>> =A0 endif
>>> +# some pattern rules in rules.mak are confused by an empty DSOSUF,
>>> +# and UNCHECKED_GOALS for testing (docker-) can run without prior=20
>>> configure.
>>> +DSOSUF ?=3D ".so"
>>> +
>>> =A0 # Always point to the root of the build tree (needs GNU make).
>>> =A0 BUILD_DIR=3D$(CURDIR)
>>> @@ -526,15 +530,16 @@ $(SOFTMMU_FUZZ_RULES): $(edk2-decompressed)
>>> =A0 $(TARGET_DIRS_RULES):
>>> =A0=A0=A0=A0=A0 $(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $=
(dir $@)=20
>>> V=3D"$(V)" TARGET_DIR=3D"$(dir $@)" $(notdir $@),)
>>> -DTC_MAKE_ARGS=3D-I$(SRC_PATH)/dtc VPATH=3D$(SRC_PATH)/dtc -C dtc V=3D=
"$(V)"=20
>>> LIBFDT_srcdir=3D$(SRC_PATH)/dtc/libfdt
>>> -DTC_CFLAGS=3D$(CFLAGS) $(QEMU_CFLAGS)
>>> -DTC_CPPFLAGS=3D-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc=20
>>> -I$(SRC_PATH)/dtc/libfdt
>>> -
>>> -.PHONY: dtc/all
>>> -dtc/all: .git-submodule-status dtc/libfdt dtc/tests
>>
>> I'm getting:
>>
>> config-host.mak is out-of-date, running configure
>> make: *** No rule to make target 'dtc/all', needed by 'config-host.h'.=
=20
>> Stop.
>>
>> On second try it works.
>=20
> FYI same happens when going back (previous this patch applied) but ther=
e=20
> is nothing we can do to prevent that afaik:

hmm maybe preserving the previous name for the phony rule "dtc/all" could=
 make it work both forward and backward..
I'll try it in v3.

>=20
> config-host.mak is out-of-date, running configure
> make: *** No rule to make target 'libfdt', needed by 'config-host.h'.  =
Stop.
>=20
>>
>> Instead of alarming users, we could keep this target as a silent no-op=
,=20
>> then remove it after some time.
>>
>> For the rest, patch looks good, nice cleanup!

I am tempted to remove the old compatibility gunks that are marked as "to=
 be removed some time after 4.1" as the second patch in the series,
any thoughts? (Markus?)

Ciao,

Claudio

>>
>> Regards,
>>
>> Phil.
>>
>>> -=A0=A0=A0 $(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS)=20
>>> CPPFLAGS=3D"$(DTC_CPPFLAGS)" CFLAGS=3D"$(DTC_CFLAGS)"=20
>>> LDFLAGS=3D"$(QEMU_LDFLAGS)" ARFLAGS=3D"$(ARFLAGS)" CC=3D"$(CC)" AR=3D=
"$(AR)"=20
>>> LD=3D"$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
>>> +LIBFDT_objdir =3D dtc/libfdt
>>> +-include $(SRC_PATH)/dtc/libfdt/Makefile.libfdt
>>> +LIBFDT_objects =3D $(addprefix $(LIBFDT_objdir)/, $(LIBFDT_OBJS))
>>> +.PHONY: libfdt
>>> +libfdt: .git-submodule-status $(LIBFDT_objdir)/libfdt.a
>>> +$(LIBFDT_objdir)/libfdt.a: $(LIBFDT_objects)
>>> +=A0=A0=A0 $(if $(LIBFDT_objects),$(call quiet-command,rm -f $@ && $(=
AR) rcs=20
>>> $@ $^,"AR","$(TARGET_DIR)$@"),)
>>> -dtc/%: .git-submodule-status
>>> +$(LIBFDT_objects): | $(LIBFDT_objdir)
>>> +$(LIBFDT_objdir): .git-submodule-status
>>> =A0=A0=A0=A0=A0 @mkdir -p $@
>>> =A0 # Overriding CFLAGS causes us to lose defines added in the=20
>>> sub-makefile.
>>> @@ -563,7 +568,6 @@ slirp/all: .git-submodule-status
>>> =A0 # Compatibility gunk to keep make working across the rename of ta=
rgets
>>> =A0 # for recursion, to be removed some time after 4.1.
>>> -subdir-dtc: dtc/all
>>> =A0 subdir-capstone: capstone/all
>>> =A0 subdir-slirp: slirp/all
>>> @@ -821,7 +825,6 @@ distclean: clean
>>> =A0=A0=A0=A0=A0 rm -rf $$d || exit 1 ; \
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 done
>>> =A0=A0=A0=A0=A0 rm -Rf .sdk
>>> -=A0=A0=A0 if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS=
)=20
>>> clean; fi
>>> =A0 KEYMAPS=3Dda=A0=A0=A0=A0 en-gb=A0 et=A0 fr=A0=A0=A0=A0 fr-ch=A0 i=
s=A0 lt=A0 no=A0 pt-br=A0 sv \
>>> =A0 ar=A0=A0=A0=A0=A0 de=A0=A0=A0=A0 en-us=A0 fi=A0 fr-be=A0 hr=A0=A0=
=A0=A0 it=A0 lv=A0 nl=A0=A0=A0=A0=A0=A0=A0=A0 pl =20
>>> ru=A0=A0=A0=A0 th \
>>> diff --git a/configure b/configure
>>> index 233c671aaa..36f83ffc5a 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -4278,10 +4278,6 @@ EOF
>>> =A0=A0=A0=A0=A0=A0=A0 if test -d "${source_path}/dtc/libfdt" || test =
-e=20
>>> "${source_path}/.git" ; then
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt=3Dgit
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mkdir -p dtc
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ "$pwd_is_source_path" !=3D "y" ] ; =
then
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 symlink "$source_path/dtc/Ma=
kefile" "dtc/Makefile"
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 symlink "$source_path/dtc/sc=
ripts" "dtc/scripts"
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt_cflags=3D"-I\$(SRC_PATH)/dtc/li=
bfdt"
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt_ldflags=3D"-L\$(BUILD_DIR)/dtc/=
libfdt"
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fdt_libs=3D"$fdt_libs"
>>> @@ -8151,7 +8147,7 @@ echo "PIXMAN_CFLAGS=3D$pixman_cflags" >>=20
>>> $config_host_mak
>>> =A0 echo "PIXMAN_LIBS=3D$pixman_libs" >> $config_host_mak
>>> =A0 if [ "$fdt" =3D "git" ]; then
>>> -=A0 echo "config-host.h: dtc/all" >> $config_host_mak
>>> +=A0 echo "config-host.h: libfdt" >> $config_host_mak
>>> =A0 fi
>>> =A0 if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
>>> =A0=A0=A0 echo "config-host.h: capstone/all" >> $config_host_mak
>>> diff --git a/rules.mak b/rules.mak
>>> index 694865b63e..61eb474ba4 100644
>>> --- a/rules.mak
>>> +++ b/rules.mak
>>> @@ -105,6 +105,8 @@ LINK =3D $(call quiet-command, $(LINKPROG) $(CFLA=
GS)=20
>>> $(QEMU_LDFLAGS) -o $@ \
>>> =A0 DSO_OBJ_CFLAGS :=3D -fPIC -DBUILD_DSO
>>> =A0 module-common.o: CFLAGS +=3D $(DSO_OBJ_CFLAGS)
>>> +
>>> +# Note: DSOSUF must not be empty, or these rules will try to match=20
>>> too much
>>> =A0 %$(DSOSUF): QEMU_LDFLAGS +=3D $(LDFLAGS_SHARED)
>>> =A0 %$(DSOSUF): %.mo
>>> =A0=A0=A0=A0=A0 $(call LINK,$^)
>>>
>=20


