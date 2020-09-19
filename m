Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9EC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577DF2098B
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8T+4jCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577DF2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJedz-0002eZ-FH
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 11:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJecy-0001ke-Ij
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJecv-0001NA-VB
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600528693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1wdizTraeB+f93y0beGbwvbUYq+yCcz6j4bdBEAiNI=;
 b=Q8T+4jCtZKae+kE4V2dWvbG1PgwDGPAwR8TvA4/n8bUVQ1b4E26UAhK+tRFDuiQlHt/QpO
 H8v+XQ54rRfF3xl5yu7pctz5x5ksQ2YfGjqHOvRHz6GX4ZRKaWXg8/m66YHGwABmobeAJA
 960hJxW3E5KB13lba+FqPX1+IkPUluA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-DmbcJWpVPKSKa8R7xSwJ8A-1; Sat, 19 Sep 2020 11:18:11 -0400
X-MC-Unique: DmbcJWpVPKSKa8R7xSwJ8A-1
Received: by mail-wr1-f69.google.com with SMTP id a2so3540681wrp.8
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 08:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F1wdizTraeB+f93y0beGbwvbUYq+yCcz6j4bdBEAiNI=;
 b=SmA3SKQyXDPA95KkQ8dqnMRMPgnOFUuWSKNddXSdpb/7rZaJqYR7MAEX+ZQsslDjM2
 Bpp6GUhJNj+AJOm6W82ntOmtXYF6lP8PPO+EpukWxevMRpdeE+oF6zyXNWrdNsrUbMdA
 U+XTu3IOQxYZYhIr9/cAerwPq2qmIv3a8EtHaCkLUx2DIDeaGsrqYEJJUaX+pQ2K6G2c
 JOJi3HLpnwdNxYr4QAaWBRAFzifFR+WyP4QoLYGrHrOW6pG43aT9OAT8EhlkdcI9H6cN
 rTBD/3fDgruRwlNmWchjUe8dbuvAEnr/IMxQggiHtboWSiPtzCsREpeiiH6QrjJpWIP7
 1WHQ==
X-Gm-Message-State: AOAM530z73Svq141rHMfqLhtHn8bKYnZNuiKdBfWWyocA4H0zdtEPFzo
 IgfpTYSikWBS7oFd4ely0F1orHSFI/RH9OTq92mrp/y6opwhPyYTzM9uWGzzb6HumypvAEAkHMM
 9o5eZNgoEYtKTihM=
X-Received: by 2002:a1c:18e:: with SMTP id 136mr3770713wmb.22.1600528690001;
 Sat, 19 Sep 2020 08:18:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1j3Yd2lQGVrSGMPrRgbsbhXTbECP5ydlpNTj9PZ4T5DCXYNYAl4oOC1kBBq8of5+Jay+mbw==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr3770683wmb.22.1600528689747;
 Sat, 19 Sep 2020 08:18:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b20a:b600:521c:512d?
 ([2001:b07:6468:f312:b20a:b600:521c:512d])
 by smtp.gmail.com with ESMTPSA id k8sm11927105wma.16.2020.09.19.08.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 08:18:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] file-posix: Correctly read max_segments of SG nodes
To: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200811225122.17342-1-dmitry.fomichev@wdc.com>
 <20200811225122.17342-2-dmitry.fomichev@wdc.com>
 <808e395e-6f99-acdb-03dc-400f6bd32311@redhat.com>
 <ea4017fe0456a9c663f943f60f4572ecf8d0fe96.camel@redhat.com>
 <9f2614db9bcf570be9c9bcb0337126bc711ef432.camel@redhat.com>
 <MN2PR04MB5951128F548F519AC0E5B9A1E13E0@MN2PR04MB5951.namprd04.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0d5dbf40-133e-4dd8-de03-ec8744cb90c6@redhat.com>
Date: Sat, 19 Sep 2020 17:18:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <MN2PR04MB5951128F548F519AC0E5B9A1E13E0@MN2PR04MB5951.namprd04.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/20 18:44, Dmitry Fomichev wrote:
> 
> Maxim, looks like you are on top of this problem and your approach sounds
> sensible too me. Just FYI, it is also possible to avoid using SG_GET_SG_TABLESIZE
> ioctl and rely entirely on sysfs, but the code gets a bit more complicated (see below)

I would prefer to have the code in block/ but I have no problem if the
hardware limits are placed in a new field of bs->bl.  Then scsi-block
and scsi-generic can consult it instead of bs->bl.max_transfer.

Paolo


