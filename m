Return-Path: <SRS0=qZCI=SG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182DFC4360F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 23:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0FA206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2019 23:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0FA206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCBbC-0008EO-0h
	for qemu-devel@archiver.kernel.org; Thu, 04 Apr 2019 19:16:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCBaP-0007oL-Lq
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hCBaO-0007ha-EB
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:15:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:60682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hCBaO-0007cR-30
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 19:15:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Apr 2019 16:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; d="scan'208";a="161533022"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2019 16:15:47 -0700
Date: Fri, 5 Apr 2019 07:15:26 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190404231526.GA17148@richard>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190402132650.23095-2-armbru@redhat.com>
	<20190403223255.GB18809@richard>
	<875zrt69iy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <875zrt69iy.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.100
Subject: Re: [Qemu-devel] [PATCH 4/4] vl: Simplify machine_parse()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: pbonzini@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
	ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190404231526.k28iSUB_vW1qls0gTrcOQQXj71WCJRX2_zzkmRoImTY@z>

On Thu, Apr 04, 2019 at 06:05:25PM +0200, Markus Armbruster wrote:
>Wei Yang <richardw.yang@linux.intel.com> writes:
>
>> On Tue, Apr 02, 2019 at 03:26:50PM +0200, Markus Armbruster wrote:
>>>Exploit that argument @name is nerver null.  Check is_help_option()
>>>first, because that's what we do elsewhere.
>>>
>>>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>---
>>> vl.c | 24 +++++++++++-------------
>>> 1 file changed, 11 insertions(+), 13 deletions(-)
>>>
>>>diff --git a/vl.c b/vl.c
>>>index 6a31e5bfac..da1af3e10d 100644
>>>--- a/vl.c
>>>+++ b/vl.c
>>>@@ -2573,19 +2573,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>>> 
>>> static MachineClass *machine_parse(const char *name, GSList *machines)
>>> {
>>>-    MachineClass *mc = NULL;
>>>+    MachineClass *mc;
>>>     GSList *el;
>>> 
>>>-    if (name) {
>>>-        mc = find_machine(name, machines);
>>>-    }
>>>-    if (mc) {
>>>-        return mc;
>>>-    }
>>>-    if (name && !is_help_option(name)) {
>>>-        error_report("unsupported machine type");
>>>-        error_printf("Use -machine help to list supported machines\n");
>>>-    } else {
>>>+    if (is_help_option(name)) {
>>>         printf("Supported machines are:\n");
>>>         machines = g_slist_sort(machines, machine_class_cmp);
>>>         for (el = machines; el; el = el->next) {
>>>@@ -2597,9 +2588,16 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
>>>                    mc->is_default ? " (default)" : "",
>>>                    mc->deprecation_reason ? " (deprecated)" : "");
>>>         }
>>>+        exit(0);
>>>     }
>>>-
>>>-    exit(!name || !is_help_option(name));
>>>+        
>>>+    mc = find_machine(name, machines);
>>>+    if (!mc) {
>>>+        error_report("unsupported machine type");
>>>+        error_printf("Use -machine help to list supported machines\n");
>>>+        exit(1);
>>>+    }
>>>+    return mc;
>>
>> This change looks changed the original behavior.
>>
>> In original logic, if mc is not NULL, there is no message printed. While now
>> it rely on is_help_option(). And no it exit when !is_help_option(), while
>> before this change it exit when is_help_option().
>>
>> I don't understand the reason behind this. My suggestion is you may split this
>> patch into two:
>>
>>   1. remove check on name
>>   2. refine the logic with explanations.
>
>Cases:
>
>(1) User asks for help, i.e. is_help_option(name)
>
>(1a) and no machine named @name exists, i.e.
>     is_help_option(name) && !find_machine(name, machines)
>
>(1b) and a machine named @name exists
>     is_help_option(name) && find_machine(name, machines)
>
>(2) User asks for a machine that doesn't exist, i.e.
>    !is_help_option(name) && !find_machine(name, machines)
>
>(3) User asks for a machine that exists, i.e.
>    !is_help_option(name) && find_machine(name, machines)
>
>Since no machines are called "help" or "?", case (1b) is not actually
>possible.
>
>Old code:
>
>    static MachineClass *machine_parse(const char *name, GSList *machines)
>    {
>        MachineClass *mc = NULL;
>        GSList *el;
>
>        if (name) {
>            mc = find_machine(name, machines);
>        }
>        if (mc) {
>            return mc;
>        }
>        if (name && !is_help_option(name)) {
>            error_report("unsupported machine type");
>            error_printf("Use -machine help to list supported machines\n");
>        } else {
>            printf("Supported machines are:\n");
>            machines = g_slist_sort(machines, machine_class_cmp);
>            for (el = machines; el; el = el->next) {
>                MachineClass *mc = el->data;
>                if (mc->alias) {
>                    printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
>                }
>                printf("%-20s %s%s%s\n", mc->name, mc->desc,
>                       mc->is_default ? " (default)" : "",
>                       mc->deprecation_reason ? " (deprecated)" : "");
>            }
>        }
>
>        exit(!name || !is_help_option(name));
>    }
>
>Case (1a): print help, exit(0)
>
>Case (1b): return find_machine()
>
>Case (2): report error, exit(1)
>
>Case (3): return find_machine()
>
>New code:
>
>    static MachineClass *machine_parse(const char *name, GSList *machines)
>    {
>        MachineClass *mc;
>        GSList *el;
>
>        if (is_help_option(name)) {
>            printf("Supported machines are:\n");
>            machines = g_slist_sort(machines, machine_class_cmp);
>            for (el = machines; el; el = el->next) {
>                MachineClass *mc = el->data;
>                if (mc->alias) {
>                    printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
>                }
>                printf("%-20s %s%s%s\n", mc->name, mc->desc,
>                       mc->is_default ? " (default)" : "",
>                       mc->deprecation_reason ? " (deprecated)" : "");
>            }
>            exit(0);
>        }
>
>        mc = find_machine(name, machines);
>        if (!mc) {
>            error_report("unsupported machine type");
>            error_printf("Use -machine help to list supported machines\n");
>            exit(1);
>        }
>        return mc;
>    }
>
>Case (1a): print help, exit(0)
>
>Case (1b): print help, exit(0)
>
>Case (2): report error, exit(1)
>
>Case (3): return find_machine()
>
>The patch changes "impossible" case (1b).  That's intentional (but my
>commit message could explain it better).

This looks better. Would you mind refine it so that I could send all these
patches in v2.

Or you prefer send it out by our self?

-- 
Wei Yang
Help you, Help me

