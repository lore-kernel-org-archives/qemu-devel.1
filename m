Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655C3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DCE2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fs0+4wkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DCE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc2Kc-0005ZM-MC
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc2JY-0004eC-0h
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:14:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc2JV-00031l-Bj
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604909648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iZ2Cg1jua60qy8gsGFE+8OW/9hCVRnTBy3fwtt6p/Bg=;
 b=Fs0+4wkJgGaSySNM9pP8ABcI9q8TJ/s6zK7NUn9Dz3fWeZ4mu3iAAe56C4lFiRUXGrnI0p
 kk8AvdjpqDUlPx1Qa3PzY5bqeh1gxvkHdukS52RlmlvONxrkGoV/0pmsBXDoZ0v3/OSIOd
 PS86PGiQtf4xNu4bmzVapIVZc4LYGNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-yuXBUFCOOCKucEqviRpI6w-1; Mon, 09 Nov 2020 03:13:58 -0500
X-MC-Unique: yuXBUFCOOCKucEqviRpI6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9011A57242;
 Mon,  9 Nov 2020 08:13:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86D0260FC2;
 Mon,  9 Nov 2020 08:13:52 +0000 (UTC)
Subject: Re: [PATCH] tests/vm: update openbsd to release 6.8
To: Brad Smith <brad@comstyle.com>, Philippe Mathieu-Daud?? <philmd@redhat.com>
References: <20201027053048.GB64546@humpty.home.comstyle.com>
 <cbae54c3-fa97-19e6-512c-7ac570f56b12@redhat.com>
 <20201027102245.GC64546@humpty.home.comstyle.com>
 <2f27fba1-d5e6-6734-e608-36406e6fe00a@comstyle.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <db2e674b-7d8b-850c-1b55-880529ee601f@redhat.com>
Date: Mon, 9 Nov 2020 09:13:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2f27fba1-d5e6-6734-e608-36406e6fe00a@comstyle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/2020 07.07, Brad Smith wrote:
> ping.

It's not directly my turf, but I can add it to my next testing-related pull
request if nobody else picks this patch up before.

 Thomas

> On 10/27/2020 6:22 AM, Brad Smith wrote:
>> On Tue, Oct 27, 2020 at 11:05:20AM +0100, Philippe Mathieu-Daud?? wrote:
>>> On 10/27/20 6:30 AM, Brad Smith wrote:
>>>> tests/vm: update openbsd to release 6.8
>>>>
>>>> A double dash at the end of a package name removes ambiguity
>>>> when the intent is to install a non-FLAVORed package.
>>>>
>>>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daud?? <philmd@redhat.com>
>>> I confirm Brad sent us this patch off-list, and
>>> - our review comments are addressed,
>>> - the tags are correct.
>>>
>>> The patch format itself seems broken... Like a copy/paste
>>> into an email client...
>> Well, git diff vs a format-patch.
>>
>>
>> Subject: [PATCH] tests/vm: update openbsd to release 6.8
>>
>> A double dash at the end of a package name removes ambiguity
>> when the intent is to install a non-FLAVORed package.
>>
>> Signed-off-by: Brad Smith <brad@comstyle.com>
>> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>> Tested-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>   tests/vm/openbsd | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>> index 8356646f21..5ffa4f1b37 100755
>> --- a/tests/vm/openbsd
>> +++ b/tests/vm/openbsd
>> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>>       name = "openbsd"
>>       arch = "x86_64"
>>   -    link = "https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.iso"
>> -    csum =
>> "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4ab9436ee3"
>> +    link = "https://cdn.openbsd.org/pub/OpenBSD/6.8/amd64/install68.iso"
>> +    csum =
>> "47e291fcc2d0c1a8ae0b66329f040b33af755b6adbd21739e20bb5ad56f62b6c"
>>       size = "20G"
>>       pkgs = [
>>           # tools
>> @@ -36,10 +36,10 @@ class OpenBSDVM(basevm.BaseVM):
>>           "bash",
>>           "gmake",
>>           "gsed",
>> -        "gettext",
>> +        "gettext-tools",
>>             # libs: usb
>> -        "libusb1",
>> +        "libusb1--",
>>             # libs: crypto
>>           "gnutls",
> 


