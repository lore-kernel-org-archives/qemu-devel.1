Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20577C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E197B20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E197B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQwc3-0003vo-W7
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:18:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQwat-0003T2-1G
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hQwas-0001yI-2y
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:17:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hQwar-0001v8-SO
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:17:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so168191wrs.5
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=aeg8SVa8lIu3q85B2yqngTt8oZntQqVn91puRt3wQOI=;
	b=nk6CFPbsBRTdBtFoIZLXVkyAiURJgweASgbUG+xI5sjyfVg6Vn/tIPU59DehmuHnYw
	2DxPqES+3/hvH9+YZHJ5Gq8cjnA0c6pPUak3OD6MHykMU9o4ZmfcQl8eo1fBoTeNeZti
	YU438RxbMBz4Cl2x1RkKQK1DyEQVXaFqWMgbxeQWSDh9sAEoxKkvAmK2oKTGtMbUUJLX
	hbXieiZfgfZmGp5GsRkC97SR6QbcwZ8c1R2Z+mVdnUPPP5uXPu3dHVWktx3O9cXnsg8I
	XtnR/oTyqqTPs0RsFM6uj8bGWYQO8Sap0zRB92YFRUwNN9Cu6FbMKxYCZZN197GiNMV3
	KOAQ==
X-Gm-Message-State: APjAAAUZj3B0Q0skUjZwdtmD1TtFfZS3Yc0l1KDziPMfca6L3/SBdrPt
	DAfgy0Ejy1hb+oUCvQOIBC2xMQ==
X-Google-Smtp-Source: APXvYqxgptbLBnmKKZCvLjjrb9uxi4Z0N/z5YGqvmi9ZgS32pydqygzXXVM8wp9zsDf1bxgZIVTa1w==
X-Received: by 2002:adf:f743:: with SMTP id z3mr11911141wrp.129.1557937044045; 
	Wed, 15 May 2019 09:17:24 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id 88sm4911031wrc.33.2019.05.15.09.17.23
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 09:17:23 -0700 (PDT)
To: Stefano Garzarella <sgarzare@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
References: <20190515090805.44785-1-sgarzare@redhat.com>
	<875zqb7v9c.fsf@dusky.pond.sub.org>
	<20190515130100.rth7dnluusk75v23@steredhat>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <611f79b2-a01a-c17e-08ed-5a5bdd17b5d6@redhat.com>
Date: Wed, 15 May 2019 18:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515130100.rth7dnluusk75v23@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2] net/slirp: fix the IPv6 prefix length
 error message
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
Cc: qemu-trivial@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/19 3:01 PM, Stefano Garzarella wrote:
> On Wed, May 15, 2019 at 02:33:03PM +0200, Markus Armbruster wrote:
>> Stefano Garzarella <sgarzare@redhat.com> writes:
>>
>>> Reword and add a missing parentheses at the end of the
>>> error message.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>> v2:
>>>   - Reworded the error message (Markus)
>>>   - Added Marc-André's R-b
>>>     I made a little change to the error message, let me now
>>>     if I should remove yuor R-b.
>>> ---
>>>  net/slirp.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/slirp.c b/net/slirp.c
>>> index 95934fb36d..b34cb29276 100644
>>> --- a/net/slirp.c
>>> +++ b/net/slirp.c
>>> @@ -498,7 +498,8 @@ static int net_slirp_init(NetClientState *peer, const char *model,
>>>      }
>>>      if (vprefix6_len < 0 || vprefix6_len > 126) {
>>>          error_setg(errp,
>>> -                   "Invalid prefix provided (prefix len must be in range 0-126");
>>> +                   "Invalid IPv6 prefix provided "
>>> +                   "(IPv6 prefix length must be between 0 and 126)");
>>>          return -1;
>>>      }
>>
>> "Parameter 'ipv6-prefixlen' expects a value between 0 and 126" would be
>> closer to how we report similar errors elsewhere.
> 
> This error is shown when 'ipv6-net' or 'ipv6-prefixlen' parameters are
> used, so I preferred to leave a more generic error to fit both cases.
> 
>>
>> Regardless:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


