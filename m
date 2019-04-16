Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AF0C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4ED20818
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4ED20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGCac-0002m4-Sv
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:08:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bart.vanassche@gmail.com>) id 1hGCZq-0002Va-1p
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bart.vanassche@gmail.com>) id 1hGCZp-0003IU-2s
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:07:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bart.vanassche@gmail.com>)
	id 1hGCZo-0003I9-Pn
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:07:57 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck15so9455600plb.3
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 18:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=gepmAu+EbSLBTd3XpYQ1NggYoa+7MfGdlMgpVMREOhw=;
	b=P+hvaaHzW0YPWIhGBkrdeHKB5QQCJUnAHiLEIENogSvfljLBJ1s4CRrF3GCQa51yJ0
	EBq5AG7Hw4TYzFFXVSx9LL1tyEz1ZY4+owcJZz6cFc2g7Qtnzslzj5xTSpDgbXknhj72
	Bx+DiIgRuUNFK20/2PgTYG7DNMlDrn2XqXj4c4pcCom0wzYk1/R2h4UsgPncwTXM3Q2j
	YI349PGD1HfaMW+8QWPo0U1Jr9ZQtQJYFeL+Wuy2l5VdeGz2jvq2Rcw6nG/V6tcFLKP+
	uHPCLzely28XL9B6SeV7end1mbuySAYkkOnZNHtK//KvSAgWfP6AYek5YcBZRbmpHdFb
	UA8A==
X-Gm-Message-State: APjAAAUueAoKWrujQzfPHA89zH4fc/B3CLZjdOo7SayPA9BLBp2Dduae
	4R7KYXem5+9iTgY4VB8jdBU=
X-Google-Smtp-Source: APXvYqzIcOW4vW458lGTtk9ZDkfMYAnwpkxJ5UaFEFYL99S0K3XGSap9BMmHFKK7O0VQ8iGzWdQqKQ==
X-Received: by 2002:a17:902:8604:: with SMTP id
	f4mr68360745plo.245.1555376875141; 
	Mon, 15 Apr 2019 18:07:55 -0700 (PDT)
Received: from asus.site (c-67-188-93-131.hsd1.ca.comcast.net. [67.188.93.131])
	by smtp.gmail.com with ESMTPSA id
	h4sm65405022pfo.119.2019.04.15.18.07.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 15 Apr 2019 18:07:54 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>,
	virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org,
	mst@redhat.com, cohuck@redhat.com, marcel.apfelbaum@gmail.com,
	linux-rdma@vger.kernel.org, jgg@mellanox.com
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-4-yuval.shaia@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
	mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
	LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
	fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
	AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
	3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
	AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
	igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
	Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
	jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
	macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
	CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
	RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
	PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
	eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
	lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
	T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
	++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
	CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
	oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
	//x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
	mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
	goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <f133d122-5b00-2e3b-f5cc-efc6d2cc3d3b@acm.org>
Date: Mon, 15 Apr 2019 18:07:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411110157.14252-4-yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.196
Subject: Re: [Qemu-devel] [RFC 3/3] RDMA/virtio-rdma: VirtIO rdma driver
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416010752.NdGzE-RV-dWlDNj1PiQ_lGS6HCF7MAffWMG6cc30QbQ@z>

On 4/11/19 4:01 AM, Yuval Shaia wrote:
> +++ b/drivers/infiniband/hw/virtio/Kconfig
> @@ -0,0 +1,6 @@
> +config INFINIBAND_VIRTIO_RDMA
> +	tristate "VirtIO Paravirtualized RDMA Driver"
> +	depends on NETDEVICES && ETHERNET && PCI && INET
> +	---help---
> +	  This driver provides low-level support for VirtIO Paravirtual
> +	  RDMA adapter.

Does this driver really depend on Ethernet, or does it also work with
Ethernet support disabled?

> +static inline struct virtio_rdma_info *to_vdev(struct ib_device *ibdev)
> +{
> +	return container_of(ibdev, struct virtio_rdma_info, ib_dev);
> +}

Is it really worth to introduce this function? Have you considered to
use container_of(ibdev, struct virtio_rdma_info, ib_dev) directly instead
of to_vdev()?

> +static void rdma_ctrl_ack(struct virtqueue *vq)
> +{
> +	struct virtio_rdma_info *dev = vq->vdev->priv;
> +
> +	wake_up(&dev->acked);
> +
> +	printk("%s\n", __func__);
> +}

Should that printk() be changed into pr_debug()? The same comment holds for
all other printk() calls.

> +#define VIRTIO_RDMA_BOARD_ID	1
> +#define VIRTIO_RDMA_HW_NAME	"virtio-rdma"
> +#define VIRTIO_RDMA_HW_REV	1
> +#define VIRTIO_RDMA_DRIVER_VER	"1.0"

Is a driver version number useful in an upstream driver?

> +struct ib_cq *virtio_rdma_create_cq(struct ib_device *ibdev,
> +				    const struct ib_cq_init_attr *attr,
> +				    struct ib_ucontext *context,
> +				    struct ib_udata *udata)
> +{
> +	struct scatterlist in, out;
> +	struct virtio_rdma_ib_cq *vcq;
> +	struct cmd_create_cq *cmd;
> +	struct rsp_create_cq *rsp;
> +	struct ib_cq *cq = NULL;
> +	int rc;
> +
> +	/* TODO: Check MAX_CQ */
> +
> +	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
> +	if (!cmd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rsp = kmalloc(sizeof(*rsp), GFP_ATOMIC);
> +	if (!rsp) {
> +		kfree(cmd);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	vcq = kzalloc(sizeof(*vcq), GFP_KERNEL);
> +	if (!vcq)
> +		goto out;

Are you sure that you want to mix GFP_ATOMIC and GFP_KERNEL in a single
function?

Thanks,

Bart.

