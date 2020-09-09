Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C377C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C669B21941
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjBZsNHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C669B21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1um-0007vs-Nn
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG1po-0000RK-PD
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:16:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kG1pm-0004QD-Ve
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599664583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cPrhgoltgXvaXRabVNxfaTKwTGIJNYZHcv8NgWo8KMs=;
 b=PjBZsNHJEBEjcvor6jP/P/aBrzh1xmwxRwp8gG5y0lLqtU94XtHbhoy2hvmzR4AQtDpUWR
 w6mxqOtxi3Zwh/ocJwWv01EG1BuUC4X8LY6nSdH1G8v7SusiKRhA1a82NQTCsfPBk8uwVb
 OyIQYUba2LrLZS1rRciGjL6gH80YEWE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Q__lcSmdOK-hJlmLa10tzA-1; Wed, 09 Sep 2020 11:16:19 -0400
X-MC-Unique: Q__lcSmdOK-hJlmLa10tzA-1
Received: by mail-ed1-f72.google.com with SMTP id f16so1156944edm.10
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 08:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cPrhgoltgXvaXRabVNxfaTKwTGIJNYZHcv8NgWo8KMs=;
 b=eNxoYAb3fXpPt6w69J9l2woKn1Oc3x++w8pl+dSmW+qRm03YZZFsxWvtIKwYNpyLyH
 Gu53+v+XylM3Pd0CAzKStyEiYkhUu+Boi6FzfP0/7mN/7KX7pbGFyAaPc8jyLHAUU22m
 zn6nS8g9hDAibakPSRGnHAywhis7yeTl2RKr/BRSSRB1XFHRMqRlFIYXYCM1RQ7U5HU7
 kGpfRi3Fj3IUTGK9CqPU/qLiOEOODXOi4xGDn9fIWroz7zDynm9HVgcNMwTlzgUZN1Hy
 MqtUAgnoEwwLdy46zl2+u0DxmK0cK30+ENfFqaeTsepTIXiJ2lC15gKmB7OR+uQluZCV
 CneQ==
X-Gm-Message-State: AOAM5325KL0ua1VGQVvQs9JUcfxndKz/lqRg4321z+YRcObXtu+COLeJ
 AVidilg6jwVGvoNuCe61o0YM0eua93HVi1yhdAiTW2OuBy1O+D3lzaEoU6W72afC9Pp44996Fj1
 FzcasMql1zvkDLCY=
X-Received: by 2002:a17:906:3bca:: with SMTP id
 v10mr4039984ejf.57.1599664578087; 
 Wed, 09 Sep 2020 08:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUnq5ifaKLVhx8wU61TxbbMKuo8CEgER0/sUNB+zFswRbvBvRQRDsOHX/NGIFaQEU1wMExZg==
X-Received: by 2002:a17:906:3bca:: with SMTP id
 v10mr4039969ejf.57.1599664577903; 
 Wed, 09 Sep 2020 08:16:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4025:be55:3943:81a0?
 ([2001:b07:6468:f312:4025:be55:3943:81a0])
 by smtp.gmail.com with ESMTPSA id w10sm2701715ejv.44.2020.09.09.08.16.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 08:16:17 -0700 (PDT)
Subject: Re: [RFC] QEMU as Xcode project on macOS
To: Thomas Huth <thuth@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <2764135.D4k31Gy3CM@silver>
 <3afbbc20-410a-4466-f3c8-07b718ca8d3f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22facbc9-ab51-5bdd-c9c9-cc00fe5365de@redhat.com>
Date: Wed, 9 Sep 2020 17:16:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3afbbc20-410a-4466-f3c8-07b718ca8d3f@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: programmingkidx@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/20 15:41, Thomas Huth wrote:
>> The question is, and I don't have the big picture of QEMU yet to judge that, 
>> how much is auto generated for QEMU i.e. with custom scripts that would 
>> probably destroy this plan? There are these trace calls that are auto 
>> generated, is there more like the TCG part for instance?
> Yes, I think we generate code in a couple of places, e.g. the code in
> target/s390x/ uses a "gen-features" helper to generate some code. So
> implementing a separate Xcode project that does not use the main build
> files does not sound very appealing.

More than a couple places---all of QAPI and tracing code is autogenerated.

Perhaps Meson's xcodeproj backend can be improved to support everything
that QEMU requires, I'm not sure if there are any limitations in Xcode
that prevent that.

Paolo


