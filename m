Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2A9C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D33B21852
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 21:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D33B21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzT5S-0007Gz-DB
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 17:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1hzT4n-0006iR-QP
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hzT4m-0003yj-S4
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hzT4m-0003yG-Jl
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 17:51:00 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C10643C919
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 21:50:59 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id i4so4214241wri.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2019 14:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BWNhNplX4X1tcoHqiUKkSgvzgfJ8ZU4slJeqcVGtFrM=;
 b=HdZaNvc8KLSn/eACtWhszfyrNkMR4o/sclGlmGIPkD9raxVx3HxGpJDdK7XnRERQbw
 yk6I1QpS4CDJT+yQYOgw77weFbQjQbvvSrC3H08UiMLGr0hsAS3PWfDb3ADGxohArHBB
 1pHpbV03qCeA4QHzj/MBrzP8UrJ+uMm9trgoD/BinvYpIP1LvDPGS36T+HPWD+/Ldz8B
 R/ejWI1w0XhMFgYIZoCTQOxcuR9PMeHr42SXIMIJSCADSXeBfrZi8VTe0X8EYPDNW2ko
 rbp4HuMNatlptPi8BiwoMeB8S5xpSZeX0obijYvmbFK/9W/JwUQMtGNIpU1mDONYngTk
 DBbw==
X-Gm-Message-State: APjAAAWO58wFzBAtThujJSDMcOVcVAg4JdNh7nX1t9l9bJynED7tqzCy
 OHbKUz2SlIeCqcL/IKdzY3VsAWius/RPGXBafJguKEtch+YWJo2a2rgHablTwkx1I6DAh4ApMzb
 f/uYNEkgCreeTJkM=
X-Received: by 2002:adf:f991:: with SMTP id f17mr22066335wrr.233.1566165058600; 
 Sun, 18 Aug 2019 14:50:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzdxQWzHqQ4WicWZftVA9Zyr412KvR07zY8XboKHTOI68Un7XZet7NebCCGBzHOJpZUtTP0Og==
X-Received: by 2002:adf:f991:: with SMTP id f17mr22066327wrr.233.1566165058434; 
 Sun, 18 Aug 2019 14:50:58 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id d16sm10061096wrv.55.2019.08.18.14.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Aug 2019 14:50:57 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>, Stephen Kitt <steve@sk2.org>
References: <20190811194247.9861-1-steve@sk2.org> <20190815105704.GA3018@lap1>
 <20190815141244.25a93a3a@heffalump.sk2.org>
 <20190818122858.GA1926@lap1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b0f17467-2966-a308-f9a0-87b447317c45@redhat.com>
Date: Sun, 18 Aug 2019 23:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190818122858.GA1926@lap1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] Fix hw/rdma/vmw/pvrdma_cmd.c build
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/19 2:28 PM, Yuval Shaia wrote:
> On Thu, Aug 15, 2019 at 02:12:44PM +0200, Stephen Kitt wrote:
>> On Thu, 15 Aug 2019 13:57:05 +0300, Yuval Shaia <yuval.shaia@oracle.co=
m>
>> wrote:
>>
>>> On Sun, Aug 11, 2019 at 09:42:47PM +0200, Stephen Kitt wrote:
>>>> This was broken by the cherry-pick in 41dd30f. Fix by handling error=
s
>>>> as in the rest of the function: "goto out" instead of "return rc".
>>>>
>>>> Signed-off-by: Stephen Kitt <steve@sk2.org>
>>>> ---
>>>>  hw/rdma/vmw/pvrdma_cmd.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
>>>> index bb9a9f1cd1..a3a86d7c8e 100644
>>>> --- a/hw/rdma/vmw/pvrdma_cmd.c
>>>> +++ b/hw/rdma/vmw/pvrdma_cmd.c
>>>> @@ -514,7 +514,7 @@ static int create_qp(PVRDMADev *dev, union
>>>> pvrdma_cmd_req *req, cmd->recv_cq_handle, rings, &resp->qpn);
>>>>      if (resp->hdr.err) {
>>>>          destroy_qp_rings(rings);
>>>> -        return rc;
>>>> +        goto out; =20
>>>
>>> This label was removed, can you please check master branch?
>>
>> Sorry, it wasn=E2=80=99t clear from my message =E2=80=94 my patch is a=
gainst the stable-3.1
>> branch.

You want to Cc then ;) Doing it for you.

> I see, in that case fix make sense.
>=20
> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
>=20
>>
>> Regards,
>>
>> Stephen
>=20
>=20
>=20

