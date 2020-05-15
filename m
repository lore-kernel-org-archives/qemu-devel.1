Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C917EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DF4206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3kZoMtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DF4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWAg-0006cT-Pv
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZW9u-0005a1-6M
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:57:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZW9s-0007JE-GJ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589533051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=bB5om6XeshR+83IAfwxzMse3qpeHKRpiGqgzm5HoYU8=;
 b=a3kZoMtW2iGIatFx6/jdnL5rySvLn3ug5+iVXCQrhNahEa6Egm+s2p75OZ2/FmP2mH6o3K
 SnGZ9O0HPNZD/PDncG3I/tjTJFJ6NKoRLNNVtXB0Uc73HA7FMMZbhg/OjEACif4/izY1qS
 5XeDLKXxMpUUhdz0Ml9QJ8SJFT6oEIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-zNRCCa5MNCmx0JZyLzMsoA-1; Fri, 15 May 2020 04:57:29 -0400
X-MC-Unique: zNRCCa5MNCmx0JZyLzMsoA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81DFD18FE870;
 Fri, 15 May 2020 08:57:28 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-42.ams2.redhat.com [10.36.113.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A07DC12A4D;
 Fri, 15 May 2020 08:57:27 +0000 (UTC)
Subject: Re: [PATCH 1/3] docs/s390x: document the virtual css
To: Cornelia Huck <cohuck@redhat.com>
References: <20200505135025.14614-1-cohuck@redhat.com>
 <20200505135025.14614-2-cohuck@redhat.com>
 <7876d0f3-7bb9-38b9-6675-94ba6bd47a1a@redhat.com>
 <20200515105133.12ffb2be.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8c2abd64-39e8-8150-c4ee-546ee55ddb42@redhat.com>
Date: Fri, 15 May 2020 10:57:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515105133.12ffb2be.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/2020 10.51, Cornelia Huck wrote:
> On Fri, 15 May 2020 09:04:13 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 05/05/2020 15.50, Cornelia Huck wrote:
[...]
>>> +
>>> +  This would not show up in a standard Linux guest.  
>>
>> Ok ... and what happens if you use devno=0.0.1234 ? Will that then show
>> up under fe.0.1234 in the guest??
> 
> That won't show up in the guest, either -- do you think I should add an
> example for that as well?

It could help to clarify the question that came to my mind here. And
what would happen if the guest supported MCSS-E ? Would it then show up
as fe.0.1234 indeed?

 Thomas


