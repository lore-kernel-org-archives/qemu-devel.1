Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F6BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373EB221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW7SufAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373EB221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3mrv-0001aZ-DH
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <louisc363@gmail.com>)
 id 1k3jXH-00030K-SU
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:18:35 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:46266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <louisc363@gmail.com>)
 id 1k3jXG-000114-3X
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 13:18:35 -0400
Received: by mail-ot1-x332.google.com with SMTP id v6so25977575ota.13
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=jiKhGRX52re3eIJjnsi7RVpixiQqbIrGIKUj9n8s1Zg=;
 b=ZW7SufAprcszuG7/a2+vmjOu5LMKMGHVDWGKLHR5FYYaBa96CvIqZqL69wtdE2M+26
 pxonoZGp3oekifSkTzPvNGVNa/NnqCYV8HK+3ZFreTk9ftBzfxWuML2N/oQFyFcVEmVT
 cEGHPN6hVs00uxhMHFDdRDyNIH5d0Byd786sWNsS8SQkumudrn4lCBjAAUgKE3n6rRFL
 kPo3kd/Y1AzTyoywQMrnq/Qaz/c+ySr+yP2YnFfXG5L8FnKjLWK4+LfrteK4UU2ykzhC
 nTZDMI58vy/SJXXOIIszDNqx1adMckYe8oLiucxWuIQttNpWKhxbTCKfv4E5wFHKID5Y
 tHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=jiKhGRX52re3eIJjnsi7RVpixiQqbIrGIKUj9n8s1Zg=;
 b=pTOnD3Y0hcFcHtgeCNg7bBSOruj+LLbnqewKueppwDr3bV4y848th9RnMYe3/zjEYv
 7NWQy+I5xW/bZ5m+ONKdCsP3JblnjVZGVCqGZu9VnFko2HJjiiGYi9De8DhBHcu3M4PG
 ycAC7CAkm4AEI6Gh8Ixvj7y4Xs554EgfQ9m4/0mvocrBpGFTHrjAgn6I1auOHv2DPDEw
 +kAbG9YxIuC77lvyNY5B/PjlrJUMwyL/M4DlBxBvkM5ktIoVulTUfeQcEtDb/WQoDVDR
 u9yFgyCV521W3/1ky999dJKTaztQT1HIDw3HogsMmchCZKvJkhj0Cy1tfAw5foK1uxWl
 mgSA==
X-Gm-Message-State: AOAM530WMiw4LORty9ngNHi4wsMThZx7VAbSN0wxpe3AiOzk6o7eU7Y6
 +zrIVcVaRxSczqyYyddgU/L6jKFa4a+0VvK3UKiFVaI7PA8=
X-Google-Smtp-Source: ABdhPJynxpefn3OLKetlDuI7EDw0B4sDpvUolxqO9jDlSnIWTcF7KujpGkfygnhEIW3l1wlIe3bjk6aH/iWQ1c5UV3I=
X-Received: by 2002:a05:6830:2119:: with SMTP id
 i25mr8483708otc.131.1596734311860; 
 Thu, 06 Aug 2020 10:18:31 -0700 (PDT)
MIME-Version: 1.0
From: Louis Cloete <louisc363@gmail.com>
Date: Thu, 6 Aug 2020 19:18:11 +0200
Message-ID: <CA+BhqPZP8BCefVJi554ZfvC5zK_Tkz6yWiLQZ1Hw9b96Fmp1fQ@mail.gmail.com>
Subject: Small error in blog post
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000075913b05ac38ade5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=louisc363@gmail.com; helo=mail-ot1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 06 Aug 2020 16:51:10 -0400
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
Cc: stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000075913b05ac38ade5
Content-Type: text/plain; charset="UTF-8"

Hi!

I read your blog post
http://blog.vmsplice.net/2020/08/why-qemu-should-move-from-c-to-rust.html

I thought it was a well thought out exposition of the topic of "what shall
we do to security vulnerabilities due to C bugs. Is Rust the answer".

However, one small inaccuracy caught my eye. Rust doesn't prevent memory
leaks. Memory leaks aren't considered memory unsafe by Rust's definition.
It is possible to leak memory in safe Rust. I believe memory leaks are not
prevented, because trying to prove their absence at compile time boils down
to the halting problem.

Regards
Louis Cloete

--00000000000075913b05ac38ade5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi!</div><div><br></div><div>I read your blog post <a=
 href=3D"http://blog.vmsplice.net/2020/08/why-qemu-should-move-from-c-to-ru=
st.html">http://blog.vmsplice.net/2020/08/why-qemu-should-move-from-c-to-ru=
st.html</a></div><div><br></div><div>I thought it was a well thought out ex=
position of the topic of &quot;what shall we do to security vulnerabilities=
 due to C bugs. Is Rust the answer&quot;.</div><div><br></div><div>However,=
 one small inaccuracy caught my eye. Rust doesn&#39;t prevent memory leaks.=
 Memory leaks aren&#39;t considered memory unsafe by Rust&#39;s definition.=
 It is possible to leak memory in safe Rust. I believe memory leaks are not=
 prevented, because trying to prove their absence at compile time boils dow=
n to the halting problem.</div><div><br></div><div>Regards</div><div>Louis =
Cloete<br></div></div>

--00000000000075913b05ac38ade5--

