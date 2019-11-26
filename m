Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B66E2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfC8Y0Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B66E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZY0T-0007L8-A2
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXsH-0005g9-0R
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:15:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prashantbhole.linux@gmail.com>) id 1iZXn6-0003Vy-Lm
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:53 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:44384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <prashantbhole.linux@gmail.com>)
 id 1iZXn6-0003Vo-GQ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:09:52 -0500
Received: by mail-pj1-x1043.google.com with SMTP id w8so8053496pjh.11
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 02:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vjhBcNZlvW0lMvmwhzAhIEHJGNVVbcL/eLdp//zF+fg=;
 b=hfC8Y0GlPj/uXQPu3A2bgAU/XKe+wQFyKu/9eLipQh61lukaue4hfFzl2ix7VClJjZ
 eqSqR/bDgLg7pVcqACj11DMCuCv0gwXL7+xHhsNh5NwgCfARRwd9PlFnobWiTzP9n90N
 Cad2Cf8SKecEWov8eZLUH408k+NDKtsw7byKo/MzSxyDe560t1bn8KA8Nw44LvCzF9vm
 USGyVrg3TbYALODisuOSe3Ve8xKDQg/MXtM9pDiIBi8Zs54oRtnKLNOLXzCEtbzwdMLf
 iPJ/eSOXkY0IEK3bI3VUv0V9mmMlT1OQKz3zMG/tabHlx5zqAMJowhWzs1hYAg70KyV9
 hpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vjhBcNZlvW0lMvmwhzAhIEHJGNVVbcL/eLdp//zF+fg=;
 b=CVQlQFewAhhiN7RLm8YnklniqS+uPZmHF3V8bGkG2wLJE+I+ASYdydJoNaFbG0yCX+
 hHMpEo22eEswVK+42piVUxYTdvIyGyKGs7nEbe5mMj2yEUGpRdsICAR9iJhuZY2f22f3
 Y3pGLZT8ZI/qNShq068zMU/uTQP9IiOFVx9KDj0BlAivLgt4LYA8tw3E8jaW8DqUO9RE
 qTf9mqMb0q0n209XGORQuD8Hqef0lRXPfrgXnahfQieJhbXJXjnWFqejkObHrMI+FSFD
 QuDxVU162x4zptgMjKrgNbFvTH4A+xIHtvLDjrCcKsYtWOdeZ+YKXtL2ytWN4SYpc1gC
 nsdw==
X-Gm-Message-State: APjAAAXtnd+t5hnperiL9htMB4nhdu/cxonVSdT8vCFSshQ2tUBesXhD
 b/jZLzMwWgoL857+aQzPhyo=
X-Google-Smtp-Source: APXvYqzqJGhF3OWpPSeJBTojUttgXbH4VXymhLmS8Ad3+dmUNyuhjPT2iweDPV8n33fEjuC8F6+rjQ==
X-Received: by 2002:a17:90a:a612:: with SMTP id
 c18mr5725937pjq.49.1574762991777; 
 Tue, 26 Nov 2019 02:09:51 -0800 (PST)
Received: from localhost.localdomain ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id s24sm11848485pfh.108.2019.11.26.02.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2019 02:09:51 -0800 (PST)
From: Prashant Bhole <prashantbhole.linux@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC net-next 18/18] virtio_net: restrict bpf helper calls from
 offloaded program
Date: Tue, 26 Nov 2019 19:07:44 +0900
Message-Id: <20191126100744.5083-19-prashantbhole.linux@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
References: <20191126100744.5083-1-prashantbhole.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Song Liu <songliubraving@fb.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, qemu-devel@nongnu.org,
 Prashant Bhole <prashantbhole.linux@gmail.com>, kvm@vger.kernel.org,
 Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
 Martin KaFai Lau <kafai@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we are offloading this program to the host, some of the helper
calls will not make sense. For example get_numa_node_id. Some helpers
can not be used because we don't handle them yet.

So let's allow a small set of helper calls for now.

Signed-off-by: Prashant Bhole <prashantbhole.linux@gmail.com>
---
 drivers/net/virtio_net.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 91a94b787c64..ab5be6b95bbd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2549,6 +2549,25 @@ static struct virtnet_bpf_map *virtnet_get_bpf_map(struct virtnet_info *vi,
 	return NULL;
 }
 
+static int virtnet_bpf_check_helper_call(struct bpf_insn *insn)
+{
+	switch (insn->imm) {
+	case BPF_FUNC_map_lookup_elem:
+	case BPF_FUNC_map_update_elem:
+	case BPF_FUNC_map_delete_elem:
+	case BPF_FUNC_ktime_get_ns:
+	case BPF_FUNC_get_prandom_u32:
+	case BPF_FUNC_csum_update:
+	case BPF_FUNC_xdp_adjust_head:
+	case BPF_FUNC_xdp_adjust_meta:
+	case BPF_FUNC_xdp_adjust_tail:
+	case BPF_FUNC_strtol:
+	case BPF_FUNC_strtoul:
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
+
 static int virtnet_bpf_verify_insn(struct bpf_verifier_env *env, int insn_idx,
 				   int prev_insn)
 {
@@ -2830,6 +2849,7 @@ static int virtnet_bpf_verifier_setup(struct bpf_prog *prog)
 	struct virtnet_bpf_bound_prog *state;
 	struct virtnet_bpf_map *virtnet_map;
 	struct bpf_map *map;
+	u8 opcode, class;
 	struct fd mapfd;
 	int i, err = 0;
 
@@ -2846,6 +2866,16 @@ static int virtnet_bpf_verifier_setup(struct bpf_prog *prog)
 	for (i = 0; i < state->len; i++) {
 		struct bpf_insn *insn = &state->insnsi[i];
 
+		opcode = BPF_OP(insn->code);
+		class = BPF_CLASS(insn->code);
+
+		if ((class == BPF_JMP || class == BPF_JMP32) &&
+		    opcode == BPF_CALL && insn->src_reg != BPF_PSEUDO_CALL) {
+			if (virtnet_bpf_check_helper_call(insn))
+				return -EOPNOTSUPP;
+			continue;
+		}
+
 		if (insn->code != (BPF_LD | BPF_IMM | BPF_DW))
 			continue;
 
-- 
2.20.1


