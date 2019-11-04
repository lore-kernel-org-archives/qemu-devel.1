Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF74CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFE52245D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Wijligwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFE52245D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYPM-0007tq-CU
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ross.lagerwall@citrix.com>) id 1iRYOB-0007Ky-WA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ross.lagerwall@citrix.com>) id 1iRYOA-00077n-E6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:11:07 -0500
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:31680)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ross.lagerwall@citrix.com>)
 id 1iRYOA-00076I-1c; Mon, 04 Nov 2019 04:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1572858665;
 h=subject:to:cc:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=LXrcgvn/cfVd3yuWIl3PyyQdjB9O7s/4wApADABMytM=;
 b=Wijligwp3PKwJ6ccN5EBh121U97ZhIpxfE8/DkAwt4U8FddgfxTLseXq
 S/Gtgf8H5FFOjvRtN86CCSmbx1CDp7HDibgLcmP1TKaIpXTkKoDaSIJvi
 OHJqLU8uLsjUrE1c6l2iAaETn6vjJFJkA8PknsD2N52cPbWXSQJ92RoaU g=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=ross.lagerwall@citrix.com;
 spf=Pass smtp.mailfrom=ross.lagerwall@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 ross.lagerwall@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="ross.lagerwall@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 ross.lagerwall@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="ross.lagerwall@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="ross.lagerwall@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: m3U8Jmy5FkSZCdd+xP/AlUlzsKuTKW0kZ7+z16i3bBOdLLlYfirA1IN+zQTknyqnsA4r6vFQfe
 C2oeFBkAKpYBIqeSAblgJb/AFMs+6RHPNsa0hpv/mdtE9G6VqEWY3CGgvGU2bKHoMqa4udSIPs
 Xm0jbLwHuVtCOL3oOBu/i4bHc49wNnlojja7mA9FANLO+ls1GDylPGz7ouFaFRRa17AVbSrrOW
 9MCY2WKOcU9mgfWjAfKF/aZWprknGhgU1oM9H0eOzqf4jj27AgLp81WIa840zVTEunym1lD1fh
 mxw=
X-SBRS: 2.7
X-MesageID: 8281892
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.68,266,1569297600"; 
   d="scan'208";a="8281892"
Subject: Re: [Qemu-devel] [PATCH 16/16] nvme: support multiple namespaces
To: Klaus Birkelund <its@irrelevant.dk>
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
 <79fb195f-91dc-869d-f290-40fdcb96eea3@citrix.com>
 <20190823081022.GA30440@apples.localdomain>
 <675ecf34-4874-7a10-998a-f85c4aeb9526@citrix.com>
 <20191104090449.GA128558@apples.localdomain>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <41ff0b87-6e0a-467c-6469-bdc6103a6b78@citrix.com>
Date: Mon, 4 Nov 2019 09:11:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191104090449.GA128558@apples.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.144
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
Cc: kwolf@redhat.com, keith.busch@intel.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 9:04 AM, Klaus Birkelund wrote:
> On Mon, Nov 04, 2019 at 08:46:29AM +0000, Ross Lagerwall wrote:
>> On 8/23/19 9:10 AM, Klaus Birkelund wrote:
>>> On Thu, Aug 22, 2019 at 02:18:05PM +0100, Ross Lagerwall wrote:
>>>> On 7/5/19 8:23 AM, Klaus Birkelund Jensen wrote:
>>>>
>>>> I tried this patch series by installing Windows with a single NVME
>>>> controller having two namespaces. QEMU crashed in get_feature /
>>>> NVME_VOLATILE_WRITE_CACHE because req->ns was NULL.
>>>>
>>>
>>> Hi Ross,
>>>
>>> Good catch!
>>>
>>>> nvme_get_feature / nvme_set_feature look wrong to me since I can't see how
>>>> req->ns would have been set. Should they have similar code to nvme_io_cmd to
>>>> set req->ns from cmd->nsid?
>>>
>>> Definitely. I will fix that for v2.
>>>
>>>>
>>>> After working around this issue everything else seemed to be working well.
>>>> Thanks for your work on this patch series.
>>>>
>>>
>>> And thank you for trying out my patches!
>>>
>>
>> One more thing... it doesn't handle inactive namespaces properly so if you
>> have two namespaces with e.g. nsid=1 and nsid=3 QEMU ends up crashing in
>> certain situations. The patch below adds support for inactive namespaces.
>>
>> Still hoping to see a v2 some day :-)
>>
>  
> Hi Ross,
> 
> v2[1] is actually out, but only CC'ed Paul. Sorry about that! It fixes
> the support for discontiguous nsid's, but does not handle inactive
> namespaces correctly in identify.
> 
> I'll incorporate that in a v3 along with a couple of other fixes I did.
> 
> Thanks!
> 
> 
>   [1]: https://patchwork.kernel.org/cover/11190045/
> 

Thanks for pointing me at that, I missed it.

Regards,
-- 
Ross Lagerwall

