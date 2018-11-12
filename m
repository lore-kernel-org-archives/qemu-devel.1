Received: from eggs.gnu.org ([2001:4830:134:3::10]:37461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gM8U6-0006np-72
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gM8U1-0006Sb-Ty
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:26:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gM8U1-0006Cn-CK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 04:26:13 -0500
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
	<20181109125947-mutt-send-email-mst@kernel.org>
	<CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
	<20181111215232-mutt-send-email-mst@kernel.org>
	<CAOEp5Oe_TFTpQ_yBGJ-OyCw_Zne7bF0nUGV8XpG+4Fd+TJ7i8g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b800852b-e81e-459c-c6e1-15d4c99fc0eb@redhat.com>
Date: Mon, 12 Nov 2018 17:25:59 +0800
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oe_TFTpQ_yBGJ-OyCw_Zne7bF0nUGV8XpG+4Fd+TJ7i8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: support RSC v4/v6 tcp traffic
 for Windows HCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>


On 2018/11/12 =E4=B8=8B=E5=8D=884:57, Yuri Benditovich wrote:
>
> On Mon, Nov 12, 2018 at 4:54 AM Michael S. Tsirkin <mst@redhat.com=20
> <mailto:mst@redhat.com>> wrote:
>
>     On Sun, Nov 11, 2018 at 12:18:54PM +0200, Yuri Benditovich wrote:
>     >=C2=A0 =C2=A0 =C2=A0> @@ -66,12 +143,16 @@ typedef struct VirtIONe=
t {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 VirtIONetQueue *vqs;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 VirtQueue *ctrl_vq;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0 NICState *nic;
>     >=C2=A0 =C2=A0 =C2=A0> +=C2=A0 =C2=A0 QTAILQ_HEAD(, NetRscChain) rs=
c_chains;
>     >
>     >=C2=A0 =C2=A0 =C2=A0what exactly happens with these chains on migr=
ation?
>     >
>     >
>     > This feature (software implementation of RSC in QEMU) is
>     intended to be used in
>     > the environment of certification tests which never uses migration=
.
>
>     Should this feature disable migration then?
>
>
> IMO, this should not. But if you find it mandatory, please respond and=20
> I will add the migration blocker.


So if my understanding is correct, it's safe to do nothing even if we=20
allow migration for RSC?

Thanks
