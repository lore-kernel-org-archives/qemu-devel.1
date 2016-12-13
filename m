Received: from eggs.gnu.org ([2001:4830:134:3::10]:41359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cGlL6-0003EC-Ln
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cGlL2-0003PF-ME
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:33:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cGlL2-0003P7-Gx
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:33:40 -0500
Date: Tue, 13 Dec 2016 17:03:15 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <995759159.4566665.1481626321833.JavaMail.zimbra@redhat.com>
Message-ID: <alpine.LFD.2.20.1612131700340.6298@wniryva>
References: <20161213071439.32322-1-ppandit@redhat.com>
	<995759159.4566665.1481626321833.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] display: virtio-gpu-3d: check virgl
 capabilities max_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhenhao Hong <zhenhaohong@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

+-- On Tue, 13 Dec 2016, Pankaj Gupta wrote --+
| > +    if (max_size) {
| > +        resp->hdr.type = VIRTIO_GPU_RESP_OK_CAPSET;
| > +        virgl_renderer_fill_caps(gc.capset_id,
| > +                                 gc.capset_version,
| > +                                 (void *)resp->capset_data);
| > +    }
| >      virtio_gpu_ctrl_response(g, cmd, &resp->hdr, sizeof(*resp) + max_size);
| 
| Just one point here for 'max_size=0', do we don't require to set resp->hdr.type?

  I thought hdr.type is if capabilities data is set.

| If yes,  other patch on list by 'Li Qiang' can also help to avoid sending garbage value.

  g_malloc0 one? Yes.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
