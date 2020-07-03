Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16200C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39DA206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39DA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLJt-000369-1R
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jrLIw-0002RL-Nm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:00:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:55478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jrLIu-0003gr-HV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:00:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3E73EAE17;
 Fri,  3 Jul 2020 13:00:30 +0000 (UTC)
Subject: Re: [PULL 04/10] build: fix device module builds
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200702122048.27798-1-kraxel@redhat.com>
 <20200702122048.27798-5-kraxel@redhat.com>
 <a7af3c56-98ab-16e2-afaf-383757b03720@suse.de>
 <20200703102541.dz47mjnmustpuowl@sirius.home.kraxel.org>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <8ae6be66-5605-f71f-64c1-97e1b2bfa724@suse.de>
Date: Fri, 3 Jul 2020 15:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200703102541.dz47mjnmustpuowl@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 23:00:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 12:25 PM, Gerd Hoffmann wrote:
> On Fri, Jul 03, 2020 at 11:01:43AM +0200, Claudio Fontana wrote:
>> On 7/2/20 2:20 PM, Gerd Hoffmann wrote:
>>> See comment.  Feels quite hackish.  Better ideas anyone?
>>
>> A better idea could be to investigate what and why gets into the variable.
> 
> I see paths prefixed by "../", which seems to come from recursing into
> target directories and not properly handling -m there.
> 
> I think this stop-gap will do the job fine as long as we don't have
> target-specific modules.
> 
> With the pending switch to a meson-based build system which I hope
> simplifies all this I didn't feel like investing too much effort into
> finding the real root cause.  Debugging the Makefiles is a PITA ...
> 
> I'm open to any hints though.
> 
> take care,
>   Gerd
> 

Hi, if I recall correctly I encountered this.

It has to do with the convoluted rules in rules.mak for modules.

There are multiple specific problems there, beyond design issues.

one is

%$(DSOSUF): %.mo

this breaks and causes all sorts of misbehavior for make rules that do not require ./configure.

it can be worked around by providing a default definition in rules.mak for DSOSUF.

One other issue is the corresponding recipe

$(if $(findstring /,$@),$(call quiet-command,cp $@ $(subst /,-,$@),"CP","$(subst /,-,$@)"))

This causes more than one problem (for example, it is the reason qemu can "rebuild" stuff for no apparent reason after doing a full make).

In addition to that, this does not work well when called from the target dir.

If I remember correctly I solved this only building modules from a recursive build, ie my Makefile had:

commit 250cb13eb1fb4d4b29552acb0b768616321886ef
Author: Claudio Fontana <cfontana@suse.de>
Date:   Wed May 13 19:13:15 2020 +0200

    Makefile: add recurse-modules
    
    Signed-off-by: Claudio Fontana <cfontana@suse.de>

diff --git a/Makefile b/Makefile
index 34275f57c9..5ec1ff2c2f 100644
--- a/Makefile
+++ b/Makefile
@@ -479,7 +479,7 @@ dummy := $(call unnest-vars,, \
 
 include $(SRC_PATH)/tests/Makefile.include
 
-all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
+all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all recurse-modules $(vhost-user-json-y)
 
 qemu-version.h: FORCE
        $(call quiet-command, \
@@ -497,7 +497,7 @@ config-host.h-timestamp: config-host.mak
 qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
        $(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
 
-TARGET_DIRS_RULES := $(foreach t, all fuzz clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
+TARGET_DIRS_RULES := $(foreach t, all fuzz clean install modules, $(addsuffix /$(t), $(TARGET_DIRS)))
 
 SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
 $(SOFTMMU_ALL_RULES): $(authz-obj-y)
@@ -580,8 +580,9 @@ ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
 $(ROM_DIRS_RULES):
        $(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $
(notdir $@),)

-.PHONY: recurse-all recurse-clean recurse-install
+.PHONY: recurse-all recurse-modules recurse-clean recurse-install
 recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
+recurse-modules: $(addsuffix /modules, $(TARGET_DIRS))
 recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
 recurse-install: $(addsuffix /install, $(TARGET_DIRS))
 $(addsuffix /install, $(TARGET_DIRS)): all
@@ -757,6 +758,8 @@ clean-coverage:
                "CLEAN", "coverage files")
 endif
 
+modules: recurse-modules
+
 clean: recurse-clean
 # avoid old build problems by removing potentially incorrect old files
        rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h


-----------------

and then my rules.mak had:

@@ -106,11 +111,12 @@ LINK = $(call quiet-command, $(LINKPROG) $(CFLAGS) $(QEMU_LDFLAGS) -o $@ \
 DSO_OBJ_CFLAGS := -fPIC -DBUILD_DSO
 module-common.o: CFLAGS += $(DSO_OBJ_CFLAGS)
 %$(DSOSUF): QEMU_LDFLAGS += $(LDFLAGS_SHARED)
-%$(DSOSUF): %.mo
+../%$(DSOSUF): DEST=$(subst /,-,$(subst ../,,$@))
+../%$(DSOSUF): ../%.mo
+       @# Link non-accelerator, non-target-specific modules
        $(call LINK,$^)
        @# Copy to build root so modules can be loaded when program started without install
-       $(if $(findstring /,$@),$(call quiet-command,cp $@ $(subst /,-,$@),"CP","$(subst /,-,$@)"))
-
+       $(call quiet-command,cp $@ ../$(DEST),"CP","$(DEST)")
 
 LD_REL := $(CC) -nostdlib $(LD_REL_FLAGS)
 
@@ -364,7 +370,7 @@ define unnest-vars
                    $(eval $($o-objs): CFLAGS += $(DSO_OBJ_CFLAGS))
                    $(eval $o: $($o-objs)))
              $(eval $(patsubst %-m,%-y,$v) += $($v))
-             $(eval modules: $($v:%.mo=%$(DSOSUF))),
+             $(if $(findstring accel-,$(v)),,$(eval modules: $($v:%.mo=%$(DSOSUF)))),
              $(eval $(patsubst %-m,%-y,$v) += $(call expand-objs, $($v)))))
 
     # Post-process all the unnested vars





