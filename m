Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CF5C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:27:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A01B2206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A01B2206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYS8Z-00044t-P1
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jYS7v-0003gC-G7
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:45638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jYS7t-0005Mp-Q9
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:27:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 22094ABB2;
 Tue, 12 May 2020 10:27:05 +0000 (UTC)
Subject: Re: [PATCH RESEND v3 0/2] Makefile: libfdt: build only the strict
 necessary
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200411093150.4741-1-cfontana@suse.de>
 <20200414020303.GC48061@umbus.fritz.box>
 <47c51117-133c-9b88-4dec-b56d883f5e8b@suse.de>
 <20200511063352.GR2183@umbus.fritz.box>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <23981ca0-28e1-3ea5-7a5c-a5279a335691@suse.de>
Date: Tue, 12 May 2020 12:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200511063352.GR2183@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:56:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe Mathieu-Daude <philmd@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Alex Bennee <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 8:33 AM, David Gibson wrote:
> On Wed, Apr 15, 2020 at 10:16:52AM +0200, Claudio Fontana wrote:
>> On 4/14/20 4:03 AM, David Gibson wrote:
>>> On Sat, Apr 11, 2020 at 11:31:48AM +0200, Claudio Fontana wrote:
>>>> v2 -> v3:
>>>>
>>>> * changed into a 2 patch series; in the second patch we remove the old
>>>>   compatibility gunks that were meant for removal some time after 4.1.
>>>>
>>>> * renamed the libfdt PHONY rule to dtc/all, with the intent to make
>>>>   existing working trees forward and backward compatible across the change.
>>>>
>>>> v1 -> v2:
>>>>
>>>> * fix error generated when running UNCHECKED_GOALS without prior configure,
>>>>   for example during make docker-image-fedora. Without configure, DSOSUF is
>>>>   empty, and the module pattern rule in rules.mak that uses this variable
>>>>   can match too much; provide a default in the Makefile to avoid it.
>>>>
>>>> * only attempt to build the archive when there is a non-empty list of objects.
>>>>   This could be done in general for the %.a: pattern in rules.mak, but maybe
>>>>   there are valid reasons to build an empty .a?
>>>>
>>>> * removed some intermediate variables that did not add much value
>>>>   (LIBFDT_srcdir, LIBFDT_archive)
>>>>
>>>> Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
>>>> and with docker-image-fedora, docker-test-debug@fedora that failed
>>>> before.
>>>
>>> Seems reasonable to me.  It's a bit of a shame that we can't use the
>>> dtc makefiles more simply for this.  But I don't quickly know how to
>>> fix them upstream to allow that.
>>
>>
>> Hi David,
> 
> Sorry it's taken so long to reply.
> 
>> I tried to look at dtc upstream makefiles, I don't see a perfect
>> solution at the moment.
>>
>> I came up with this idea though (not fully tested..) that _could_
>> work, ie special casing the libfdt target when it is the only goal
>> in MAKECMDGOALS.
>>
>> Any thoughts?
> 
> Bit of a hack, but still better than what we have now.  If you post
> that for dtc upstream <devicetree-compiler@vger.kernel.org>, I'd apply
> it.
> 
> Another improvement would be to not include these files on a "make
> clean" - it's kind of annoying how a make clean will regenerate all
> these before removing them.
> 

Hi David,

seems it works well also integrated with qemu, and there should be no problem in make clean,
as the version_gen should not get created anymore, the overall clean rule should take care
of objects and libs.

While bolting it to qemu I noticed that _avoiding_ passing down CFLAGS _and_ QEMU_CFLAGS is
necessary to avoid compilation errors. With those changes made, the integration of the
modified dtc seems to work.

the diff needed in qemu (note the absence of DTC_CFLAGS passed down as CFLAGS):

From: Claudio Fontana <cfontana@suse.de>
Date: Tue, 12 May 2020 12:24:55 +0200
Subject: [PATCH] Makefile: dtc: build the libfdt target

call the libfdt target from the dtc Makefile, which has been
changed to not require bison, flex, etc.

scripts/ symlink and tests directory creation are not necessary,
and neither is calling the clean rule explicitly.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 Makefile  | 8 +++-----
 configure | 1 -
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 34275f57c9..3b88e5eb99 100644
--- a/Makefile
+++ b/Makefile
@@ -527,12 +527,11 @@ $(TARGET_DIRS_RULES):
 	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
 
 DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
-DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
-DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
+DTC_CPPFLAGS=-I$(SRC_PATH)/dtc/libfdt
 
 .PHONY: dtc/all
-dtc/all: .git-submodule-status dtc/libfdt dtc/tests
-	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)
+dtc/all: .git-submodule-status dtc/libfdt
+	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt,)
 
 dtc/%: .git-submodule-status
 	@mkdir -p $@
@@ -820,7 +819,6 @@ distclean: clean
 	rm -rf $$d || exit 1 ; \
         done
 	rm -Rf .sdk
-	if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
 
 KEYMAPS=da     en-gb  et  fr     fr-ch  is  lt  no  pt-br  sv \
 ar      de     en-us  fi  fr-be  hr     it  lv  nl         pl  ru     th \
diff --git a/configure b/configure
index 0d69c360c0..42554792ec 100755
--- a/configure
+++ b/configure
@@ -4281,7 +4281,6 @@ EOF
           mkdir -p dtc
           if [ "$pwd_is_source_path" != "y" ] ; then
               symlink "$source_path/dtc/Makefile" "dtc/Makefile"
-              symlink "$source_path/dtc/scripts" "dtc/scripts"
           fi
           fdt_cflags="-I\$(SRC_PATH)/dtc/libfdt"
           fdt_ldflags="-L\$(BUILD_DIR)/dtc/libfdt"
-- 
2.16.4







