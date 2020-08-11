Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAD5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BB120771
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BB120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Y3g-0004ka-EO
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k5Y2t-00044m-8d
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:26:43 -0400
Received: from relay68.bu.edu ([128.197.228.73]:53621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k5Y2q-0007iS-Ps
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:26:42 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 07BHPe9v017251
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 11 Aug 2020 13:25:43 -0400
Date: Tue, 11 Aug 2020 13:25:40 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 139/147] meson: replace create-config with meson
 configure_file
Message-ID: <20200811172540.6cdrroa7zlegxgf4@mozz.bu.edu>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-140-git-send-email-pbonzini@redhat.com>
 <21cc800d-c8bf-b737-1059-b83044ad9271@redhat.com>
 <3fa2ac37-b2c1-cc90-28b0-e8361472b331@redhat.com>
 <20200811171202.dx3vxjbxdoj5hcxw@mozz.bu.edu>
 <2d46d239-cc2f-7d28-3db2-c01c4d42ae58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d46d239-cc2f-7d28-3db2-c01c4d42ae58@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 13:26:39
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200811 1916, Paolo Bonzini wrote:
> On 11/08/20 19:12, Alexander Bulekov wrote:
> > On 200811 1825, Philippe Mathieu-Daudé wrote:
> >> On 8/11/20 6:20 PM, Philippe Mathieu-Daudé wrote:
> >>> On 8/10/20 7:08 PM, Paolo Bonzini wrote:
> >>>> Move the create-config logic to meson.build; create a
> >>>> configuration_data object and let meson handle the
> >>>> quoting and output.
> >>>>
> >>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>>> ---
> >>>>  Makefile                       |   2 +-
> >>>>  block.c                        |   4 +-
> >>>>  configure                      |   9 ++-
> >>>>  meson.build                    | 100 ++++++++++++++++++++++---------
> >>>>  scripts/create_config          | 131 -----------------------------------------
> >>>>  tests/qtest/bios-tables-test.c |   2 +-
> >>>>  6 files changed, 80 insertions(+), 168 deletions(-)
> >>>>  delete mode 100755 scripts/create_config
> >>>>
> >>>> diff --git a/Makefile b/Makefile
> >>>> index cd4eeb5..1eec727 100644
> >>>> --- a/Makefile
> >>>> +++ b/Makefile
> >>>> @@ -189,7 +189,7 @@ clean: recurse-clean
> >>>>  	rm -f fsdev/*.pod scsi/*.pod
> >>>>  	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
> >>>>  
> >>>> -VERSION ?= $(shell cat VERSION)
> >>>> +VERSION = $(shell cat $(SRC_PATH)/VERSION)
> >>>>  
> >>>>  dist: qemu-$(VERSION).tar.bz2
> >>>>  
> >>>> diff --git a/block.c b/block.c
> >>>> index 67c5028..67ca543 100644
> >>>> --- a/block.c
> >>>> +++ b/block.c
> >>>> @@ -443,13 +443,13 @@ static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
> >>>>          return 1;               /* no whitelist, anything goes */
> >>>>      }
> >>>>  
> >>>> -    for (p = whitelist_rw; *p; p++) {
> >>>> +    for (p = whitelist_rw; p < &whitelist_rw[ARRAY_SIZE(whitelist_rw)]; p++) {
> >>>
> >>> Alexander reported [*] a problem when ARRAY_SIZE(whitelist_rw) == 0 you
> >>> access an undefined address:
> >>
> >> The question is why CONFIG_BDRV_RW_WHITELIST & CONFIG_BDRV_RO_WHITELIST
> >> aren't generated by meson.build...
> > 
> > Something like this?
> > 
> > diff --git a/meson.build b/meson.build
> > index 300256bf70..d06fa56190 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -378,6 +378,8 @@ foreach k, v: config_host
> >    if arrays.contains(k)
> >      if v != ''
> >        v = '"' + '", "'.join(v.split()) + '", '
> > +    else
> > +      v = 'NULL'
> >      endif
> >      config_host_data.set(k, v)
> >    elif k == 'ARCH'
> 
> This doesn't work, because then you dereference a NULL on the first
> iteration.  I'll revert back to without the ARRAY_SIZE.
> 
> Paolo
> 

Ah. I was comparing the config-host.h against master. Missed the
ARRAY_SIZE change.
-Alex


> >>
> >>>
> >>> block.c:442:10: runtime error: index 0 out of bounds for type 'const
> >>> char *[0]'
> >>>
> >>> [*] https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02066.html
> >>>
> >>>>          if (!strcmp(format_name, *p)) {
> >>>>              return 1;
> >>>>          }
> >>>>      }
> >>>>      if (read_only) {
> >>>> -        for (p = whitelist_ro; *p; p++) {
> >>>> +        for (p = whitelist_ro; p < &whitelist_ro[ARRAY_SIZE(whitelist_ro)]; p++) {
> >>>
> >>> Ditto.
> >>>
> >>>>              if (!strcmp(format_name, *p)) {
> >>>>                  return 1;
> >>>>              }
> >>> [...]
> >>>
> >>
> > 
> 

