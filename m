Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74111C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4023320772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOwJ8UC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4023320772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUnw-0001Ln-GW
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtUms-0000TD-9D
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:32:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47034
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtUmq-0002Ow-Fx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594294339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=S2mVR5CG6ygyTCvWdjkVVVf64CqHthXCeEGFuyedGXU=;
 b=AOwJ8UC67lgE3mPx6Dp7d4CaE+jSpaq7AxNzblX+QjMfYs0BDULmfGb0FOeDB7yyThsPpk
 UZRO+EZCIuj6pqryWp5C1sGlcd1Boo87L1AQ6i6LURqRgkGTbU34GP7k3PPAbyQiGW3hn1
 deUV0eo/98Z5OMsofLURExgZHcgIfsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-laY559H1OLiVp2AvXJBZ8A-1; Thu, 09 Jul 2020 07:32:13 -0400
X-MC-Unique: laY559H1OLiVp2AvXJBZ8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C94B580BCA0;
 Thu,  9 Jul 2020 11:32:12 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E501960F8D;
 Thu,  9 Jul 2020 11:32:11 +0000 (UTC)
Subject: Re: [qemu-web PATCH] new page: conservancy.md
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200707145110.10906-1-alex.bennee@linaro.org>
 <06e4b9a6-4ea7-8d90-3aca-68c0474a57be@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <872e60f3-22e8-990b-4442-685b2f1877f5@redhat.com>
Date: Thu, 9 Jul 2020 13:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <06e4b9a6-4ea7-8d90-3aca-68c0474a57be@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/2020 17.19, Paolo Bonzini wrote:
> On 07/07/20 16:51, Alex Bennée wrote:
>> +QEMU interacts with Conservancy through a Leadership Committee,
>> +currently composed of the following members:
>> +
>> +* Alex Bennée
>> +* Paolo Bonzini
>> +* Andreas Färber
>> +* Alexander Graf
>> +* Stefan Hajnoczi
>> +* Peter Maydell
>> +
>> +The committee votes via simple majority. There cannot be more than two
>> +members employed by the same company at once.
> 
> s/two members/one third of the members (currently two)/
> 
> s/company/entity/ (because Stefan and I are still employed by Red Hat,
> not IBM).
> 
>> +
>> +If you would like to raise an issue to the Leadership Committee,
>> +please email [qemu-devel@nongnu.org](mailto:qemu-devel@nongnu.org) and
>> +CC at least one of the members so they can bring the issue forward.
>> +For private emails you can send an email
> 
> Missing "to" here.
> 
>> +[qemu@sfconservancy.org](mailto:qemu@sfconservancy.org) which is a
>> +private list that all the leadership committee are subscribed to.
> 
> Missing comma before "which", or remove "which is" altogether after
> adding the comma.
> 
> I would also add a link to the first column of _includes/footer.html.

I've done the suggested modifications and pushed the page now. Please
double-check whether it looks as expected!

Paolo, could you please update the link on
https://wiki.qemu.org/Main_Page ? I do not have the access rights to
edit that page. Once that is done, I think we can delete the old page
https://wiki.qemu.org/Conservancy in the wiki (or turn it into a
redirect page instead?).

 Thanks,
  Thomas


