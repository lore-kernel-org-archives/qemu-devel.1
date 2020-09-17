Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D0AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5362083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5362083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIteM-0004K3-4O
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kItcv-0003Xg-Ck
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:07:05 -0400
Resent-Date: Thu, 17 Sep 2020 09:07:05 -0400
Resent-Message-Id: <E1kItcv-0003Xg-Ck@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kItcs-0001E7-Sj
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:07:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600347998; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Et9+QUcy8OpRrJnDfjsXP49ddapu1licnOhnrLtewlrEZ3ZdyoRcN6Ct6x8RHn4Uk4y8YMSGwoPjLMVFDOO4z0Zy2jgepy4buZR8Gtqd43aLXcHQoZjw+T7Gi97E6xys835D7lWMi5V330Ws3y/bjlENJlwZNiqKnmC4anJGRRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600347998;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ok93ndWsYEWxnLoZ3ltdZXUfJf6bKAOBWHtXEImIv3A=; 
 b=L90IB6W1P9kKtUx0/ZXQnWE9wHY3t7e3hMMsFpJ9v6sPvKNDMS1TF5OwUKVlqH/kK0XL9xTXJVsdaXarxVlYpenyWimfzTZOzamQtrFfETaEGOaOviEkjQvCYiSlaAmcv5OdSxA35ywNix2XYAe4eU3gAEpQbN4Z2u280I6SyTc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600347996326323.8103097314885;
 Thu, 17 Sep 2020 06:06:36 -0700 (PDT)
Subject: Re: [PATCH 0/2] qpm: Minor error value corrections
Message-ID: <160034799495.8478.1874354482301811610@66eaa9a8a123>
In-Reply-To: <20200917125540.597786-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Thu, 17 Sep 2020 06:06:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 04:07:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, groug@kaod.org, berrange@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxNzEyNTU0MC41OTc3
ODYtMS1hcm1icnVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTi9BLiBJbnRlcm5hbCBlcnJvciB3aGlsZSByZWFkaW5nIGxvZyBmaWxlCgoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDA5MTcxMjU1NDAuNTk3Nzg2LTEtYXJtYnJ1QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

