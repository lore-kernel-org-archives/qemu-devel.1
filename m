Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C012C4CEC8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:42:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBBE20830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBBE20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8qWn-0002dm-JI
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 14:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53187)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8qWA-0002C5-7H
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8qW8-0001e9-6I
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:42:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8qW8-0001dy-1k
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:42:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 63A25308218D;
 Fri, 13 Sep 2019 18:41:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA4945C1D4;
 Fri, 13 Sep 2019 18:41:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E259113865F; Fri, 13 Sep 2019 20:41:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
References: <faeb030e6a1044f0fd88208edfdb1c5fafe5def9.1567171655.git.mprivozn@redhat.com>
 <87k1accq91.fsf@dusky.pond.sub.org>
 <e57985a8-6974-e2b4-a622-3b7eca50660c@redhat.com>
Date: Fri, 13 Sep 2019 20:41:55 +0200
In-Reply-To: <e57985a8-6974-e2b4-a622-3b7eca50660c@redhat.com> (Michal
 Privoznik's message of "Fri, 13 Sep 2019 15:52:15 +0200")
Message-ID: <87impw598s.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 13 Sep 2019 18:41:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] qapi/qmp-dispatch: Fix error class for
 reporting disabled commands
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com,
 Markus Armbruster <armbru@redhat.com>, lcapitulino@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Michal Privoznik <mprivozn@redhat.com> writes:

> On 9/13/19 2:52 PM, Markus Armbruster wrote:
>> Michal Privoznik <mprivozn@redhat.com> writes:
>>
>>> If a command is disabled an error is reported. But due to usage
>>> of error_setg() the class of the error is GenericError which does
>>> not help callers in distinguishing this case from a case where a
>>> qmp command fails regularly due to other reasons. Use
>>> CommandNotFound error class which is much closer to the actual
>>> root cause.
>>>
>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>> ---
>>
>> I'd like to tweak the commit message a bit:
>>
>>    qmp-dispatch: Use CommandNotFound error for disabled commands
>>
>>    If a command is disabled an error is reported.  But due to usage of
>>    error_setg() the class of the error is GenericError which does not
>>    help callers in distinguishing this case from a case where a qmp
>>    command fails regularly due to other reasons.
>>
>>    We used to use class CommandDisabled until the great error
>>    simplification (commit de253f1491 for QMP and commit 93b91c59db for
>>    qemu-ga, both v1.2.0).
>>
>>    Use CommandNotFound error class, which is close enough.
>>
>> Objections?
>>
>
> None, thanks for taking care of this.

Need to squash in:

diff --git a/tests/test-qga.c b/tests/test-qga.c
index 891aa3d322..1ca49bbced 100644
--- a/tests/test-qga.c
+++ b/tests/test-qga.c
@@ -668,7 +668,7 @@ static void test_qga_blacklist(gconstpointer data)
     error = qdict_get_qdict(ret, "error");
     class = qdict_get_try_str(error, "class");
     desc = qdict_get_try_str(error, "desc");
-    g_assert_cmpstr(class, ==, "GenericError");
+    g_assert_cmpstr(class, ==, "CommandNotFound");
     g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
     qobject_unref(ret);
 
@@ -677,7 +677,7 @@ static void test_qga_blacklist(gconstpointer data)
     error = qdict_get_qdict(ret, "error");
     class = qdict_get_try_str(error, "class");
     desc = qdict_get_try_str(error, "desc");
-    g_assert_cmpstr(class, ==, "GenericError");
+    g_assert_cmpstr(class, ==, "CommandNotFound");
     g_assert_nonnull(g_strstr_len(desc, -1, "has been disabled"));
     qobject_unref(ret);
 

