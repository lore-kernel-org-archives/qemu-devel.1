Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6D1C2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1984720753
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 20:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUg6/bhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1984720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYbGb-0008Sm-AY
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 16:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYbFo-0007xG-1B
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:11:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jYbFm-0002hm-4y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 16:11:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id e26so23578780wmk.5
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oFWR84pC7R1oYgU8sts5u3wS5oyXtEHIRCzjpXdgk5A=;
 b=BUg6/bhHGlN6E9o9XYrzZAR2Al7Qb85c7ioeSbPW/35z9okT3xb+QM/qmt5Bw9m/yt
 2NjWAxjcmU+YhyL0Xauqxf75klmr19PvGTSUxejVC25aosoBfD2PvN6eCSjFj9lOuZ3P
 rGbcn8wV4P/nJ3Z4fn/qNaDh5lQXRgYMN9WNjjduFr9ExwLmeh3LQxL0tw3IxAtKW8lb
 /L4WTUhQZiPL/d3NdF8OrVH8xMgr924obCjMMP0+AVdHawzDBkW7Hgbre6N2Ftoj4Eo8
 78Wi7GCn8sVtzPMfRFgff/S51trNqWI3eOxX3Ybmr86xkyowRcNbLw0w7Qghrp/a5IPG
 v0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oFWR84pC7R1oYgU8sts5u3wS5oyXtEHIRCzjpXdgk5A=;
 b=fz55LQVEkzihyPaLXUm0WdIm2V9gGEXXAPWp47qZDAzn1EH3LtlfFoAs3AT3ABDocK
 8CpgbUx93EwmMCyP6/l1phrQr5eCnYHT5xsyaAGRIKKTZN7aT9z6azS7G1Xf5wRKcPZR
 GyWbFv1e5fQ7l4DSJVNPm2uov4LeH7tjSZ/blQujr0wUkL3UmCp1+I+7LZcLStwnfQ+7
 EGlxsvgZlyGkMXWi72NkrVCZWp0G+XjK/H+/12F2SKLrB59vhGuJl3AtQyOxToIbuiZ5
 d7ZAjwiqPV6DI/9mmbNWe/f1PgJZiUMHigkHUFyuIeocSXcpMNo/XTLVEb2lzrYGXU0J
 zIrA==
X-Gm-Message-State: AGi0PubZhvEi81jI7Fc7G7qpMp4bv5cTj8Mg5cJzyoFNoa7QfN8dwZq9
 6h1zP0FmhMD0/+1GB5uvZAjUyQ==
X-Google-Smtp-Source: APiQypL8JQsbDB8ILVPa5i4S93Uq38ITkPjC2OAWlJAbgBTaqt2GlHvK5GO5WNgXVn8uurMlaUS0dA==
X-Received: by 2002:a1c:98c9:: with SMTP id a192mr17098258wme.48.1589314308364; 
 Tue, 12 May 2020 13:11:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 89sm23950622wrj.37.2020.05.12.13.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 13:11:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4AAFF1FF7E;
 Tue, 12 May 2020 21:11:46 +0100 (BST)
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <f4feb648-7dc5-ac54-bc0b-db650dd176f1@vivier.eu>
 <CAEme+7EtF6B2+2U_yF2dd-g2m+=S3P5=DL1oLmHfmWw2S7PYAw@mail.gmail.com>
 <20200509230016.GA109593@sff>
 <CAEme+7H82A2RNk5g09rmhThxW4=6sqWP5o65OCsJ8zf1L-nb+w@mail.gmail.com>
 <20200512005521.GA198983@sff>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
In-reply-to: <20200512005521.GA198983@sff>
Date: Tue, 12 May 2020 21:11:46 +0100
Message-ID: <87zhacewvx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 riku.voipio@iki.fi, Laurent Vivier <laurent@vivier.eu>,
 Nikolay Igotti <igotti@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> On Mon, May 11, 2020 at 18:53:19 +0300, Nikolay Igotti wrote:
>> Attached to the mail counter.c when running with attached test.c compiled
>> to Linux standalone binary shows failing assert, unless the patch is
>> applied.
>
> I didn't get the attachment. Can you paste the code at the end of your
> reply?

So the problem is we are recycling cpu_index:

  21:01:54 [alex@zen:~/l/q/b/all.plugin] plugins/next|=E2=97=8F2=E2=9C=9A3=
=E2=80=A6(+8 insertions(+)) 127 + ./x86_64-linux-user/qemu-x86_64 ./tests/t=
cg/x86_64-linux-user/threadcount
  cpu_list_add: 0x5605598579f0
  cpu_get_free_index: 0
  cpu_list_add: 0x5605598c6010
  cpu_get_free_index: 1
  cpu_list_add: 0x5605598ec330
  cpu_get_free_index: 2
  cpu_list_add: 0x560559912a30
  cpu_get_free_index: 3
  cpu_list_add: 0x560559939130
  cpu_get_free_index: 4
  cpu_list_add: 0x56055995d360
  cpu_get_free_index: 1
  **
  ERROR:/home/alex/lsrc/qemu.git/plugins/core.c:205:qemu_plugin_vcpu_init_h=
ook: assertion failed: (success)
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x7fa2=
9c702613

However I'm confused as to how. The cpu_index is really just a function
of the number of CPUs in the cpus list and I can't see where we free
them up. We never call cpu_common_unrealizefn so the list should never
shrink. We should just end up with a slowly growing list of now dead CPU
states.

I'm giving up for now but will have a look again in the morning if no
one else has figured out what is going on by then.

>
> Thanks,
> 		Emilio


--=20
Alex Benn=C3=A9e

