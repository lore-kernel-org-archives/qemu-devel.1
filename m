Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4440C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 05:40:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A248217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 05:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A248217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36421 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCHaM-0004qV-Gp
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 01:40:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hCHZb-0004Xi-UG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hCHZa-0002r4-MZ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:39:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hCHZa-0002ld-D0
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 01:39:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AE6F8AE5F;
	Fri,  5 Apr 2019 05:39:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA556091F;
	Fri,  5 Apr 2019 05:39:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 29D9B1138648; Fri,  5 Apr 2019 07:39:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190311060823.18360-1-richardw.yang@linux.intel.com>
	<20190402132650.23095-2-armbru@redhat.com>
	<20190403223255.GB18809@richard> <875zrt69iy.fsf@dusky.pond.sub.org>
	<20190404231526.GA17148@richard>
Date: Fri, 05 Apr 2019 07:39:25 +0200
In-Reply-To: <20190404231526.GA17148@richard> (Wei Yang's message of "Fri, 5
	Apr 2019 07:15:26 +0800")
Message-ID: <87o95lovsi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Fri, 05 Apr 2019 05:39:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405053925.BF1EeYEUlg9LtTBKP9Mv7fvp2qlsBuK-VmEJxZxuGok@z>

Wei Yang <richardw.yang@linux.intel.com> writes:

> On Thu, Apr 04, 2019 at 06:05:25PM +0200, Markus Armbruster wrote:
>>Wei Yang <richardw.yang@linux.intel.com> writes:
>>
>>> On Tue, Apr 02, 2019 at 03:26:50PM +0200, Markus Armbruster wrote:
>>>>Exploit that argument @name is nerver null.  Check is_help_option()
>>>>first, because that's what we do elsewhere.
>>>>
>>>>Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>>---
>>>> vl.c | 24 +++++++++++-------------
>>>> 1 file changed, 11 insertions(+), 13 deletions(-)
>>>>
>>>>diff --git a/vl.c b/vl.c
>>>>index 6a31e5bfac..da1af3e10d 100644
>>>>--- a/vl.c
>>>>+++ b/vl.c
>>>>@@ -2573,19 +2573,10 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
>>>> 
>>>> static MachineClass *machine_parse(const char *name, GSList *machines)
>>>> {
>>>>-    MachineClass *mc = NULL;
>>>>+    MachineClass *mc;
>>>>     GSList *el;
>>>> 
>>>>-    if (name) {
>>>>-        mc = find_machine(name, machines);
>>>>-    }
>>>>-    if (mc) {
>>>>-        return mc;
>>>>-    }
>>>>-    if (name && !is_help_option(name)) {
>>>>-        error_report("unsupported machine type");
>>>>-        error_printf("Use -machine help to list supported machines\n");
>>>>-    } else {
>>>>+    if (is_help_option(name)) {
>>>>         printf("Supported machines are:\n");
>>>>         machines = g_slist_sort(machines, machine_class_cmp);
>>>>         for (el = machines; el; el = el->next) {
>>>>@@ -2597,9 +2588,16 @@ static MachineClass *machine_parse(const char *name, GSList *machines)
>>>>                    mc->is_default ? " (default)" : "",
>>>>                    mc->deprecation_reason ? " (deprecated)" : "");
>>>>         }
>>>>+        exit(0);
>>>>     }
>>>>-
>>>>-    exit(!name || !is_help_option(name));
>>>>+        
>>>>+    mc = find_machine(name, machines);
>>>>+    if (!mc) {
>>>>+        error_report("unsupported machine type");
>>>>+        error_printf("Use -machine help to list supported machines\n");
>>>>+        exit(1);
>>>>+    }
>>>>+    return mc;
>>>
>>> This change looks changed the original behavior.
>>>
>>> In original logic, if mc is not NULL, there is no message printed. While now
>>> it rely on is_help_option(). And no it exit when !is_help_option(), while
>>> before this change it exit when is_help_option().
>>>
>>> I don't understand the reason behind this. My suggestion is you may split this
>>> patch into two:
>>>
>>>   1. remove check on name
>>>   2. refine the logic with explanations.
>>
>>Cases:
>>
>>(1) User asks for help, i.e. is_help_option(name)
>>
>>(1a) and no machine named @name exists, i.e.
>>     is_help_option(name) && !find_machine(name, machines)
>>
>>(1b) and a machine named @name exists
>>     is_help_option(name) && find_machine(name, machines)
>>
>>(2) User asks for a machine that doesn't exist, i.e.
>>    !is_help_option(name) && !find_machine(name, machines)
>>
>>(3) User asks for a machine that exists, i.e.
>>    !is_help_option(name) && find_machine(name, machines)
>>
>>Since no machines are called "help" or "?", case (1b) is not actually
>>possible.
>>
>>Old code:
>>
>>    static MachineClass *machine_parse(const char *name, GSList *machines)
>>    {
>>        MachineClass *mc = NULL;
>>        GSList *el;
>>
>>        if (name) {
>>            mc = find_machine(name, machines);
>>        }
>>        if (mc) {
>>            return mc;
>>        }
>>        if (name && !is_help_option(name)) {
>>            error_report("unsupported machine type");
>>            error_printf("Use -machine help to list supported machines\n");
>>        } else {
>>            printf("Supported machines are:\n");
>>            machines = g_slist_sort(machines, machine_class_cmp);
>>            for (el = machines; el; el = el->next) {
>>                MachineClass *mc = el->data;
>>                if (mc->alias) {
>>                    printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
>>                }
>>                printf("%-20s %s%s%s\n", mc->name, mc->desc,
>>                       mc->is_default ? " (default)" : "",
>>                       mc->deprecation_reason ? " (deprecated)" : "");
>>            }
>>        }
>>
>>        exit(!name || !is_help_option(name));
>>    }
>>
>>Case (1a): print help, exit(0)
>>
>>Case (1b): return find_machine()
>>
>>Case (2): report error, exit(1)
>>
>>Case (3): return find_machine()
>>
>>New code:
>>
>>    static MachineClass *machine_parse(const char *name, GSList *machines)
>>    {
>>        MachineClass *mc;
>>        GSList *el;
>>
>>        if (is_help_option(name)) {
>>            printf("Supported machines are:\n");
>>            machines = g_slist_sort(machines, machine_class_cmp);
>>            for (el = machines; el; el = el->next) {
>>                MachineClass *mc = el->data;
>>                if (mc->alias) {
>>                    printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
>>                }
>>                printf("%-20s %s%s%s\n", mc->name, mc->desc,
>>                       mc->is_default ? " (default)" : "",
>>                       mc->deprecation_reason ? " (deprecated)" : "");
>>            }
>>            exit(0);
>>        }
>>
>>        mc = find_machine(name, machines);
>>        if (!mc) {
>>            error_report("unsupported machine type");
>>            error_printf("Use -machine help to list supported machines\n");
>>            exit(1);
>>        }
>>        return mc;
>>    }
>>
>>Case (1a): print help, exit(0)
>>
>>Case (1b): print help, exit(0)
>>
>>Case (2): report error, exit(1)
>>
>>Case (3): return find_machine()
>>
>>The patch changes "impossible" case (1b).  That's intentional (but my
>>commit message could explain it better).
>
> This looks better.

Amending my commit message to explain things better:

    vl: Simplify machine_parse()

    Exploit that argument @name is nerver null.  Check is_help_option()
    first, because that's what we do elsewhere.  If we (foolishly!)
    defined a machine named "help", -machine help would now print help
    instead of selecting the machine named "help".

>                    Would you mind refine it so that I could send all these
> patches in v2.
>
> Or you prefer send it out by our self?

Please send v2.

