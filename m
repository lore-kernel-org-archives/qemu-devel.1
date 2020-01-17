Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4055C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEE720730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zykv//E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEE720730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPam-0007Hp-Js
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isPZz-0006Tl-4x
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isPZx-0007zW-Sr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:14:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35875
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isPZx-0007zG-Oi
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579259657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zIH648Ouzn7zX1EtyMYcYr8CC0I2MOighb1c1IHPJHw=;
 b=Zykv//E94lY3ofHNKHt3/sRJ5m8oztv3muij/Fawawwnfbbmf3xBISXtHBU/IM+dwvcDZj
 Kf/wibjXXetID2OCzML5BlZiq3jItsXi0wbGaFHy4GTP2CuaD3MacUukttjC0lluzik1Rx
 VEPvDgygyhnpMlRJumC1lw9gLqcHGIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-Q9f9QVH2MxSBp3szZHtkDg-1; Fri, 17 Jan 2020 06:14:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C215800D5C
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:14:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 154351BC6D;
 Fri, 17 Jan 2020 11:14:12 +0000 (UTC)
Subject: Re: [PATCH v2 83/86] tests:numa-test: make top level args dynamic and
 g_autofree(cli) cleanups
To: Igor Mammedov <imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-84-git-send-email-imammedo@redhat.com>
 <20e88588-13b4-8c7d-3f97-cb2d50b85edd@redhat.com>
 <20200116180606.134cb1a6@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a0b60484-d5fb-7409-b13e-4e70d1177138@redhat.com>
Date: Fri, 17 Jan 2020 12:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116180606.134cb1a6@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Q9f9QVH2MxSBp3szZHtkDg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/2020 18.06, Igor Mammedov wrote:
> On Thu, 16 Jan 2020 17:35:32 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 15/01/2020 16.07, Igor Mammedov wrote:
>>> Use GString to pass argument to make_cli() so that it would be easy
>>> to dynamically change test case arguments from main(). The follow up
>>> patch will use it to change RAM size options depending on target.
>>>
>>> While at it cleanup 'cli' freeing, using g_autofree annotation.  
>>
>> Hmm, I'd use g_autofree for new code or do it in a separate cleanup
>> patch, but doing this here distracts quite a bit from the real changes
>> that you are doing...
> I'll split it into separate patch
> 
>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> PS:
>>>   made as a separate patch so it won't clutter followup testcase changes.
>>>
>>> CC: thuth@redhat.com
>>> CC: lvivier@redhat.com
>>> ---
>>>  tests/qtest/numa-test.c | 38 ++++++++++++++------------------------
>>>  1 file changed, 14 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
>>> index 17dd807..a696dfd 100644
>>> --- a/tests/qtest/numa-test.c
>>> +++ b/tests/qtest/numa-test.c
>>> @@ -14,16 +14,16 @@
>>>  #include "qapi/qmp/qdict.h"
>>>  #include "qapi/qmp/qlist.h"
>>>  
>>> -static char *make_cli(const char *generic_cli, const char *test_cli)
>>> +static char *make_cli(const GString *generic_cli, const char *test_cli)
>>>  {
>>> -    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
>>> +    return g_strdup_printf("%s %s", generic_cli->str, test_cli);
>>>  }  
>> [...]
>>> @@ -539,11 +529,11 @@ static void pc_hmat_erange_cfg(const void *data)
>>>  
>>>  int main(int argc, char **argv)
>>>  {
>>> -    const char *args = NULL;
>>> +    g_autoptr(GString) args = g_string_new("");  
>>
>> I think g_string_new(NULL) would be better?
>>
>>>      const char *arch = qtest_get_arch();
>>>  
>>>      if (strcmp(arch, "aarch64") == 0) {
>>> -        args = "-machine virt";
>>> +        g_string_append(args, " -machine virt")>      }  
>>
>> Is this really required? Looking at your next patch, you could also
>> simply do
>>
>>           args = " -object memory-backend-ram,id=ram,size=xxxM"
> xxx is variable so options are
>  1 build this part of CLI dynamically
>  2 mostly duplicate testcase function and include per target size there
>  3 make up a test data structure and pass that to test cases
> 
> Given simplicity of current testcases, I'd prefer continue with
> passing CLI as testcase data (option #1).

Sorry, I think I missed something here... currently I see in the next patch:

+    if (!strcmp(arch, "ppc64")) {
+        g_string_append(args, " -object
memory-backend-ram,id=ram,size=512M");
+    } else {
+        g_string_append(args, " -object
memory-backend-ram,id=ram,size=128M");
+    }

... so these are static strings which could also be handled fine without
GString? Or do you plan to update this in later patches?

 Thomas


