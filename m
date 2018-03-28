Received: from eggs.gnu.org ([2001:4830:134:3::10]:51835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f11Jh-0008G6-AO
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f11Je-00024g-9m
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 23:00:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f11Je-00024K-4K
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 22:59:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E42954040853
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 02:59:53 +0000 (UTC)
References: <1520857250-12935-1-git-send-email-thuth@redhat.com>
	<e7c0d2c8-6451-a598-f140-29916c99e514@redhat.com>
	<9d059301-fa9f-6303-5806-a2e6f7917ca5@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7a3f63c9-7778-31f0-518a-5872c41c09c3@redhat.com>
Date: Wed, 28 Mar 2018 10:59:46 +0800
MIME-Version: 1.0
In-Reply-To: <9d059301-fa9f-6303-5806-a2e6f7917ca5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>



On 2018=E5=B9=B403=E6=9C=8827=E6=97=A5 21:16, Thomas Huth wrote:
>>>  =C2=A0 # launch vde switch
>>>  =C2=A0 vde_switch -F -sock /tmp/myswitch
>>>  =C2=A0 # launch QEMU instance
>>> -qemu-system-i386 linux.img -net nic -net vde,sock=3D/tmp/myswitch
>>> +qemu-system-i386 linux.img -nic vde,sock=3D/tmp/myswitch
>> I think we should use -netdev here?
> I've had that in the original version of this patch, but Paolo suggeste=
d
> to use -nic instead since this is more "user-friendly":
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg05258.html
>
> I personally don't mind whether we use "-netdev" or "-nic" in the
> examples, as long as we finally get rid of "-net" there...

Right.

> Please let me
> know which way you prefer, so I can respin the patch again if necessary=
.
>
>   Thomas
>

But I think we should be consistent: in your patch some "-net" was=20
replaced by "-nic", but others were replaced by "-netdev".

Thanks
