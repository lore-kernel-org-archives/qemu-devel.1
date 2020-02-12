Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE31C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B78D21734
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 22:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2FLpMAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B78D21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j20Yz-000338-Qj
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 17:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j20XG-0001Vs-Ge
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j20XE-0001rI-2l
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:31:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j20XD-0001ph-VG
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 17:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581546667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6yVQEqlhZyq4LXWJ4OkH7Wc0ySrmNgQP5oVzHDbNKEU=;
 b=G2FLpMAYiYUekmQWXsePZh7t/GlNPPNM8SM/A4oyFh+PZxbT6K/htB1pkH7AxnRlJT7c8I
 q2FzAShKIfZzEbml5JSpH8Xhoe3P7r5C9MFrj7fhsgzrIDzVTLf9FNLbOYwF60nMD5/vYZ
 f+kT/D6ZNr+VgnSU3fnqrju6ZUqsmY4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-vUFCA5bcNnKKiZ4Mdzn8iw-1; Wed, 12 Feb 2020 17:31:03 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so1420073wrm.18
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 14:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w7TyhDUH9CF/q91SkvQo9Er0G4H1NYWoSVme+9Xt2sk=;
 b=G6cNPqffdvx35+YT4oEORtS1A2KvygmlCTPN09LVbLiBVo2w3JthdrjN8/Rav51j77
 21Gdjd/qStTM74DeuA4TYAG49W3YmVKPsZaYi1WYgfQ9zHu2g5aP5pMCScIZ/rIUNdqz
 PcOJlQybSPQWL8ug+mJhGltrB80V66s98C42JoNMaFNIWg8kh9NxPC6kZNK33PjZo+Hm
 gB2ivAbHKHZScPwizzPGI4158UeNFdsH26EzhliAfIuqs7qwyHULF/50ys1TY97tcv3d
 b/o2JMm+9tqNQ7g9btNC19tFnXWjnAYJOKRAIQKrowrCF6BW07gpjAS8zpvyWXayhT/z
 flCQ==
X-Gm-Message-State: APjAAAULZ7Am++zVPQutLfl+onz4zpYiXd6p6OE8r5U4IFRqjErH66b5
 HlLDsN1aoLCTI1SSfoRVhnD77RRVDaA4WFALCCAlarezqu44g63EgQwxOMZeaCLhonuhJiYrUNq
 H9KwOs6KKktz/y9A=
X-Received: by 2002:a1c:113:: with SMTP id 19mr1330698wmb.95.1581546662309;
 Wed, 12 Feb 2020 14:31:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDAochmDm0REXj7SHNLVbF09DB3iABFbfcIcrT8RNFEaB9lUOO73qgR1r2DkscpnE97fwZ0Q==
X-Received: by 2002:a1c:113:: with SMTP id 19mr1330689wmb.95.1581546662126;
 Wed, 12 Feb 2020 14:31:02 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l8sm345411wmj.2.2020.02.12.14.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 14:31:01 -0800 (PST)
Subject: Re: [PATCH] tracing: only allow -trace to override -D if set
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200211111054.27538-1-alex.bennee@linaro.org>
 <20200212153459.GE432724@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <195b1312-e86b-3b4b-5447-29a21708c931@redhat.com>
Date: Wed, 12 Feb 2020 23:31:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212153459.GE432724@stefanha-x1.localdomain>
Content-Language: en-US
X-MC-Unique: vUFCA5bcNnKKiZ4Mdzn8iw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 4:34 PM, Stefan Hajnoczi wrote:
> On Tue, Feb 11, 2020 at 11:10:54AM +0000, Alex Benn=E9e wrote:
>> Otherwise any -D settings the user may have made get ignored.
>>
>> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
>> ---
>>   trace/control.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing

If possible, please add 'Fixes: e144a605a'.


