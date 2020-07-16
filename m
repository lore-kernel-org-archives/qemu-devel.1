Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0E3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0E22076D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 21:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVRZoDkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0E22076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwB3N-0003g4-Mz
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 17:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwB2n-0003F0-Ve
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:03:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jwB2k-0001fF-P5
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 17:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594933428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TMffWeePWD85/Q9BO1dKy6JwLppvVg9D1G96uHBxN6o=;
 b=PVRZoDkOZ+WB2R8FHodUstzPzF1XoSIGptTAYKapdSTGb8dU78SuArZGWMEPl4pqBig9gu
 hE8mSv43Xst6vTr/UVhjJl3Nl7Qr3kPuyKS2V9YErd9HPErGXub2ydgWY+lFcCursIsN2k
 I193sbEmzJuQeBMOTYkd2406Uylr9s8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-PwYDl9VRPPeVLSNu9617Jg-1; Thu, 16 Jul 2020 17:03:47 -0400
X-MC-Unique: PwYDl9VRPPeVLSNu9617Jg-1
Received: by mail-wm1-f71.google.com with SMTP id c81so5575639wmd.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 14:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=TMffWeePWD85/Q9BO1dKy6JwLppvVg9D1G96uHBxN6o=;
 b=pHb+WdcYLEh0ybd3TzM0PSQ+iEUemd3Ncz1jqw+BDVsvFkCokZEsbydBajNV2Acap/
 uBwasVEZ12udWBXqYea4A8vbTWsyHIGlQ+wrLWtv22+TVPloiRs6GtPE88wRWeaoNe5O
 FTX4el8pnOGWqyTvPXRZrA1UsJ1TUFd4gJQ8Y5BlS7ThHY797M8javlfvINO4Gzt1Jgx
 G0ibQBrk52+Z3HCu/7vbRyPdJ/qqMD6mQZqIK6EN8+6PjRg5pYiMOyIuIOBs7x0Y/lmY
 +Uzx0FX6bLlpLrRWa3mpvSxyv35+IZ7LEy+ifD/7USD9vpywCKngRwm1ACcJzQHeNJks
 SCIw==
X-Gm-Message-State: AOAM532FiXJZ9qW2ynLrF0QhvidZLI53OtAtJXcQc/mVw7/ndqi3cybM
 HMdf14xooCH7eqmpbzxImbgDt84C+46uHSww4aQS3C0hOXnvV5F51UUB34B+h04Z7mOqnHDRfXq
 VHy5XmGXrgf+7b3c=
X-Received: by 2002:a5d:5441:: with SMTP id w1mr6445234wrv.381.1594933426207; 
 Thu, 16 Jul 2020 14:03:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZro3LpmZPGBGie2BQFNA1hcX2YmE7oclWvX3j6eecoZ6GwUZQf+Y1UtKjuAy/s4uNeuMImA==
X-Received: by 2002:a5d:5441:: with SMTP id w1mr6445214wrv.381.1594933425924; 
 Thu, 16 Jul 2020 14:03:45 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j75sm12042023wrj.22.2020.07.16.14.03.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2020 14:03:45 -0700 (PDT)
Subject: Re: qemu test-qga failure on mergebuild after VERSION file change:
 dependency issues??
To: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
References: <CAFEAcA-reu8gKpBMgEffStTRA+M02OWj75riXqBYXjgtOh5Z_A@mail.gmail.com>
 <159492211230.15440.2651129078319986183@sif>
 <78b8c6b3-1710-da21-68ac-194bd19437b2@redhat.com>
 <159492915780.15440.8588802536547059593@sif>
 <CAFEAcA9ejQjNMcChrGH4RMt9pERQpUx2titK527s+PQCmVUEkA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <3c908ef9-ab28-665c-b963-ecfdf5af60a6@redhat.com>
Date: Thu, 16 Jul 2020 23:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ejQjNMcChrGH4RMt9pERQpUx2titK527s+PQCmVUEkA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 16:27:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/16/20 10:15 PM, Peter Maydell wrote:
> On Thu, 16 Jul 2020 at 20:52, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>> But is it intermittent, environment-dependent? I'm trying to understand how to
>> replicate Peter's result since it seems like it would be straightforward
>> reproducer.
> 
> I blew away all my build trees and recreated them from
> scratch, and the issue went away. I'm suspicious that the
> complete lack of .d files was induced by a failed earlier
> pullreq attempt and left the build tree in a messed up state
> where it wouldn't notice that it needed to rebuild files.

If it happens again, can you try to revert aaa1b70a0b ("Makefile:
simplify MINIKCONF rules") on top of the tag you are testing, and
re-run the testing?


