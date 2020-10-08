Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AD5C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A1A21897
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHj5thLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A1A21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQp1-0007G4-8B
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQQnv-00069e-1i
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQQnt-0001id-G1
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602143852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jY/me8RecKqxHYw7vq1NTViBU6rH0MTw53W0jHT7OFw=;
 b=NHj5thLAeijrP5PvHSbQ5YviOI3IiCiJwSjWXOlPhApzDWZ0VImEh7GvdEaWpJllfx8hjO
 +npCEVLgE20ETN+ED38fvwyySPcI0rnIAd343320ogCVhXoXQkkggtcjnCnSzJXf77u6CM
 9nRD0UACb5RXK8HzEJfYx87MlrvTz/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-kHWoJH0bP4G4C6OEgcHt2g-1; Thu, 08 Oct 2020 03:57:29 -0400
X-MC-Unique: kHWoJH0bP4G4C6OEgcHt2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE6441018F83;
 Thu,  8 Oct 2020 07:57:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-40.ams2.redhat.com [10.36.113.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38D035DA2A;
 Thu,  8 Oct 2020 07:57:21 +0000 (UTC)
Subject: Re: [PATCH] Fixing LGPL version number
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Chetan Pant <chetan4windows@gmail.com>, qemu-trivial@nongnu.org
References: <20201008060528.68579-1-chetan4windows@gmail.com>
 <df199cc8-c383-ed03-6244-7a204e92397b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ba4f81dd-8e5c-1d50-311c-fdc41f9cc504@redhat.com>
Date: Thu, 8 Oct 2020 09:57:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <df199cc8-c383-ed03-6244-7a204e92397b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/10/2020 09.54, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 10/8/20 8:05 AM, Chetan Pant wrote:
>> There is no "version 2" of the "Lesser" General Public License. It is
>> either "GPL version 2.0" or "LGPL version 2.1". This patch replaces all
>> occurrences of "LGPL version 2" with "LGPL version 2.1" in comment section.
> 
> This looks like a good cleanup!
> 
> Since you already listed all the files using this license,
> it can be a good opportunity to correct and use the full
> license text (which is miswritten in various places):
> 
> ---
> 
>  Copyright (C) <year> <name of author>
> 
> This library is free software; you can redistribute it and/or modify it
> under the terms of the GNU Lesser General Public License as published by
> the Free Software Foundation; either version 2.1 of the License, or (at
> your option) any later version.
> 
> This library is distributed in the hope that it will be useful, but
> WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
> General Public License for more details.
> 
> You should have received a copy of the GNU Lesser General Public License
> along with this library; if not, write to the Free Software Foundation,
> Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

Please don't use that version. If the FSF move to another office again, we
have to update the whole mess again.

> Or simpler, add the SPDX identifier tag:
> 
>   SPDX-License-Identifier: LGPL-2.1-or-later

SPDX tags would be cool, of course, but it could also be done in a separate
patch later.

 Thomas


