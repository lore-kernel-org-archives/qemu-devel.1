Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169DC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A2F1215A4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 20:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1GAc0+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2F1215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFO2V-0007FS-W0
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 16:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFO1g-0006WD-Gj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:46:08 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:40264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFO1e-0005FI-DW
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 16:46:08 -0400
Received: by mail-lj1-x233.google.com with SMTP id s205so17431132lja.7
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=NF4eBqQNeaOfRrwyAw47IMO3sf/Cr493sS3H1tGv+4I=;
 b=h1GAc0+3H0jKR3ZPdR/EZIESb1LZyCmgriuZynUQvrYLZtLWFjn2yqxljy5LQY/+Mr
 jou3SN1XWtPTgWp4XuFtRAKsfYpI1OVtJDQg3bW+CiyWNJJbe/BZdpaCR/7HchZ+5H9Y
 qkAFefFxt5ktPyD3WcmJqO0s20R8naa64MMZ5RSsska1BLZR9pSsa5sJFtK9IAG/PcQ+
 u/XYXCEmKPjrua1B67BzcLYNGEkGZbaWEzDNLswEiXOmIrvUrAIbWSUovTXb6PZTn+0z
 onBZVCRH4KixSs2YW6s7ia+4az+xQCNMkaam+CX2LftalR6pHR42w0tRwlEb5LkoHVHn
 kEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=NF4eBqQNeaOfRrwyAw47IMO3sf/Cr493sS3H1tGv+4I=;
 b=Qbd9MqPSkO88c+zzIU1FOA90VL65XDDtB+Vq0+qW1LEDn8JDgvgTRSHvoShylR6y4S
 uIBQfYaA8bUcDyKCeFh3wbnTjjgH3ia7jEe98rYWxBIxNCooKptZ6Io46JG7r+1okHP0
 e6rbtIBabsN+4yYWTW+4G4c9sCw3kRuEfPQH1RkbXCV3uiF2YnGZbBwF2B8KJtHxOHWq
 eHb2Epdaw0odO8lEzhrtXsKo3W5dncBhKpLzs8ZgmZkVML0TVgZlYA/mdeFfamKpc/yi
 WLiOSk/ndkilSEhk/70mpvR97vW8SEUDuWn79pxGWsjs2pEu/mXQJdLNJIQfYxczefCP
 BuoA==
X-Gm-Message-State: AOAM532j+ixpWK7fDRqiGpVij4zZUKZy1tPCB7QMmSmeeGYoEC/u1yls
 T/V8I3J4Zfu3OtVIJw7bdaSvX7Sy3BJZnc5wD34=
X-Google-Smtp-Source: ABdhPJyOw6Zf7Qq6E2QxzDaZEWt9f3r9d3fcSqwYX2XYEgOaaGD9zTOi9vETcxF34sDvfC8PvEjfie3JMNS3+qq8ozo=
X-Received: by 2002:a2e:89d6:: with SMTP id c22mr132226ljk.242.1599511564356; 
 Mon, 07 Sep 2020 13:46:04 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 04:45:53 +0800
Message-ID: <CAE2XoE_k-=TT8S3vjbf_4c0kR96NhZ87zmfrYBxbStXyeb=FLA@mail.gmail.com>
Subject: Where does these TPM flags comes from?
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000009b8fbf05aebf4eae"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x233.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009b8fbf05aebf4eae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

tpm_ss =3D ss.source_set()

tpm_ss.add(files('tpm_backend.c'))
tpm_ss.add(files('tpm_util.c'))
tpm_ss.add(when: 'CONFIG_TPM_PASSTHROUGH', if_true:
files('tpm_passthrough.c'))
tpm_ss.add(when: 'CONFIG_TPM_EMULATOR', if_true: files('tpm_emulator.c'))

softmmu_ss.add_all(when: 'CONFIG_TPM', if_true: tpm_ss)

I can not found the config for CONFIG_TPM_PASSTHROUGH  and
CONFIG_TPM_EMULATOR

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000009b8fbf05aebf4eae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">tpm_ss =3D ss.source_set()<br><br>tpm_ss.add(files(&#39;tp=
m_backend.c&#39;))<br>tpm_ss.add(files(&#39;tpm_util.c&#39;))<br>tpm_ss.add=
(when: &#39;CONFIG_TPM_PASSTHROUGH&#39;, if_true: files(&#39;tpm_passthroug=
h.c&#39;))<br>tpm_ss.add(when: &#39;CONFIG_TPM_EMULATOR&#39;, if_true: file=
s(&#39;tpm_emulator.c&#39;))<br><br>softmmu_ss.add_all(when: &#39;CONFIG_TP=
M&#39;, if_true: tpm_ss)<br><br>I can not found the config for CONFIG_TPM_P=
ASSTHROUGH=C2=A0 and=C2=A0

CONFIG_TPM_EMULATOR=C2=A0<div><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000009b8fbf05aebf4eae--

