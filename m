Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjLWu-0007nU-Pj
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cjLWr-0005zO-Ol
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:52:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cjLWr-0005z6-If
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 02:52:01 -0500
References: <1488259090-30034-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1488259090-30034-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<958bdddd-003c-c785-e7e6-f700f1d87bc0@redhat.com>
	<64fa3338-3771-4f19-7882-8a028aac87a4@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <01b98ebb-feb2-c0f6-62ed-8b3d1712a028@redhat.com>
Date: Thu, 2 Mar 2017 15:51:54 +0800
MIME-Version: 1.0
In-Reply-To: <64fa3338-3771-4f19-7882-8a028aac87a4@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 2/3] COLO-compare: Optimize
 compare_common and compare_tcp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, bian naimeng <biannm@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 2017=E5=B9=B402=E6=9C=8828=E6=97=A5 14:11, Zhang Chen wrote:
>>
>
> OK, How about this?
>
> +    /*
> +     * Because of ppkt and spkt are both in the same connection,
> +     * The ppkt's src ip, dst ip, src port, dst port, ip_proto all are
> +     * same with spkt. In addition, IP header's Identification is a=20
> random
> +     * field, we can handle it in IP fragmentation function later.
> +     * So we just compare the ip payload here. we ignored all IP heade=
r
> +     * include other field like TOS,TTL,IP Checksum.
> +     */
>
> Thanks
> Zhang Chen

But this does not explain why we can ignore those fields.

Thanks
