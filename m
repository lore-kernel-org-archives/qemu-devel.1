Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32274C73C42
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE292082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE292082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkoml-0006uw-T7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51871)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <borntraeger@de.ibm.com>) id 1hkolr-0006Tq-7p
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1hkolp-000054-AZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:58:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1hkoln-0008U6-HT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:58:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x69BvVKT081061
 for <qemu-devel@nongnu.org>; Tue, 9 Jul 2019 07:58:47 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tmtbegf4t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 07:58:46 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Tue, 9 Jul 2019 12:58:44 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Jul 2019 12:58:41 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x69Bwepd46596296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jul 2019 11:58:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4F0BDAE053;
 Tue,  9 Jul 2019 11:58:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1488FAE051;
 Tue,  9 Jul 2019 11:58:40 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.150])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jul 2019 11:58:40 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190702113414.6896-1-armbru@redhat.com>
 <20190702113414.6896-5-armbru@redhat.com>
 <e7916e59-75a9-cfd2-a2a3-ab30787a60e6@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Tue, 9 Jul 2019 13:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e7916e59-75a9-cfd2-a2a3-ab30787a60e6@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19070911-0008-0000-0000-000002FB428B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070911-0009-0000-0000-00002268A2AC
Message-Id: <bc9172f0-631f-4230-96dc-dd534222db82@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-09_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090148
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x69BvVKT081061
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] make distclean /clean does not work on fresh
 repository (was: Re: Makefile: Reuse all's recursion machinery for clean
 and install)
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is still broken with qemu/master.=20

make clean/distclean no longer works on a fresh repository. As the make w=
ill return an error
this can break any kind of scripts.


On 05.07.19 23:31, Christian Borntraeger wrote:
> This seems to break "make clean" and "make distclean" in the source dir=
ectory if there was never
> a configure.
>=20
> qemu]$ make clean
>   LD      recurse-clean.mo
> cc: fatal error: no input files
> compilation terminated.
> make: *** [rules.mak:118: recurse-clean.mo] Error 1
>=20
>=20
>=20
> On 02.07.19 13:34, Markus Armbruster wrote:
>> Targets "clean" and "install" run make recursively in a for loop.
>> This ignores -j and -k.  Target "all" depends on SUBDIR/all to recurse
>> into each SUBDIR.  Behaves nicely with -j and -k.  Put that to use for
>> "clean" and "install": depend on SUBDIR/clean or SUBDIR/install,
>> respectively, and delete the loop.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-Id: <20190528082308.22032-5-armbru@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>  Makefile | 53 +++++++++++++++++++++++++----------------------------
>>  1 file changed, 25 insertions(+), 28 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index e68982bd99..8cf6cbc4c4 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -454,20 +454,22 @@ config-host.h-timestamp: config-host.mak
>>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxt=
ool
>>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN=
","$@")
>> =20
>> -SUBDIR_RULES=3D$(addsuffix /all, $(TARGET_DIRS))
>> -SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu/all,$(SUBDIR_RULES))
>> +TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$=
(t), $(TARGET_DIRS)))
>> =20
>> -$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
>> -$(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
>> -$(SOFTMMU_SUBDIR_RULES): $(chardev-obj-y)
>> -$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
>> -$(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
>> -$(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
>> -$(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
>> +SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
>> +$(SOFTMMU_ALL_RULES): $(authz-obj-y)
>> +$(SOFTMMU_ALL_RULES): $(block-obj-y)
>> +$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
>> +$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
>> +$(SOFTMMU_ALL_RULES): $(io-obj-y)
>> +$(SOFTMMU_ALL_RULES): config-all-devices.mak
>> +$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
>> =20
>> -.PHONY: $(SUBDIR_RULES)
>> -$(SUBDIR_RULES):
>> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$=
(V)" TARGET_DIR=3D"$(dir $@)" all,)
>> +.PHONY: $(TARGET_DIRS_RULES)
>> +# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
>> +# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub=
-goal
>> +$(TARGET_DIRS_RULES):
>> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$=
(V)" TARGET_DIR=3D"$(dir $@)" $(notdir $@),)
>> =20
>>  DTC_MAKE_ARGS=3D-I$(SRC_PATH)/dtc VPATH=3D$(SRC_PATH)/dtc -C dtc V=3D=
"$(V)" LIBFDT_srcdir=3D$(SRC_PATH)/dtc/libfdt
>>  DTC_CFLAGS=3D$(CFLAGS) $(QEMU_CFLAGS)
>> @@ -500,19 +502,19 @@ capstone/all: .git-submodule-status
>>  slirp/all: .git-submodule-status
>>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR=3D"$(BUI=
LD_DIR)/slirp" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" RANLIB=3D"$(RANLIB)=
" CFLAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(LDFLAGS)")
>> =20
>> -$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
>> +$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) =
\
>>  	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
>> =20
>>  ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
>> -ROMSUBDIR_RULES=3D$(addsuffix /all, $(ROM_DIRS))
>> +ROM_DIRS_RULES=3D$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIR=
S)))
>>  # Only keep -O and -g cflags
>> -.PHONY: $(ROMSUBDIR_RULES)
>> -$(ROMSUBDIR_RULES):
>> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$=
(V)" TARGET_DIR=3D"$(dir $@)" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))",)
>> +.PHONY: $(ROM_DIRS_RULES)
>> +$(ROM_DIRS_RULES):
>> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$=
(V)" TARGET_DIR=3D"$(dir $@)" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))" $(no=
tdir $@),)
>> =20
>> -ALL_SUBDIRS=3D$(TARGET_DIRS) $(ROM_DIRS)
>> -
>> -recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
>> +recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
>> +recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
>> +recurse-install: $(addsuffix /install, $(TARGET_DIRS))
>> =20
>>  $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
>>  	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","versio=
n.o")
>> @@ -661,7 +663,7 @@ clean-coverage:
>>  		"CLEAN", "coverage files")
>>  endif
>> =20
>> -clean:
>> +clean: recurse-clean
>>  # avoid old build problems by removing potentially incorrect old file=
s
>>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm=
.h gen-op-arm.h
>>  	rm -f qemu-options.def
>> @@ -682,9 +684,6 @@ clean:
>>  	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
>>  	rm -f qapi-gen-timestamp
>>  	rm -rf qga/qapi-generated
>> -	for d in $(ALL_SUBDIRS); do \
>> -	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
>> -        done
>>  	rm -f config-all-devices.mak
>> =20
>>  VERSION ?=3D $(shell cat VERSION)
>> @@ -832,7 +831,8 @@ endif
>>  ICON_SIZES=3D16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
>> =20
>>  install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-=
localstatedir \
>> -	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
>> +	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
>> +	recurse-install
>>  ifneq ($(TOOLS),)
>>  	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DES=
TDIR)$(bindir))
>>  endif
>> @@ -898,9 +898,6 @@ endif
>>  		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_d=
atadir)/keymaps"; \
>>  	done
>>  	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_data=
dir)/trace-events-all"
>> -	for d in $(TARGET_DIRS); do \
>> -	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=3D$$d/ -C $$d $@ || exit 1 ; =
\
>> -        done
>> =20
>>  .PHONY: ctags
>>  ctags:
>>


