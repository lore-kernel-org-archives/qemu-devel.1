Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gPedt-0001lV-NM
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gPedo-0001nE-N5
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:22:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gPedo-0001kE-GY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:22:52 -0500
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
	<20181121115718.GN26577@redhat.com>
	<20181121072237-mutt-send-email-mst@kernel.org>
	<60500f8b-47e8-c530-076a-d7f14d0f0ee5@redhat.com>
	<20181121123929-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bf59e483-d958-29ac-5e17-50f56405c629@redhat.com>
Date: Thu, 22 Nov 2018 10:22:42 +0800
MIME-Version: 1.0
In-Reply-To: <20181121123929-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>


On 2018/11/22 =E4=B8=8A=E5=8D=881:39, Michael S. Tsirkin wrote:
> On Wed, Nov 21, 2018 at 11:30:41AM -0600, Eric Blake wrote:
>> On 11/21/18 6:23 AM, Michael S. Tsirkin wrote:
>>
>>>> I agree it is good to preserve fcntl flags though, so this patch
>>>> looks desirable.
>>>>
>>>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>> Sure
>>>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> but really not for this release I guess as we are in freeze.
>> We're in freeze, so the criteria is: Does this fix a bug that we would
>> otherwise not want in 3.1.  If the code is pre-existing (that is, if 3=
.0 was
>> released with the same problem), or then delaying the patch to 4.0 is =
an
>> easier call to make.  If the problem is new to 3.1, then fixing it for=
 -rc3
>> is still reasonable with maintainer discretion (although once -rc3 lan=
ds, we
>> want as little as possible to go into -rc4, even if our track record s=
ays we
>> will be unable to avoid -rc4 altogether).
>>
>> I think that losing flags is likely enough to be a noticeable bug wort=
h
>> fixing for 3.1, but I did not research when the problem was introduced=
, so I
>> don't have a strong preference for 3.1 vs. 4.0.
> Maintainer in this case is Jason, so it's up to him


I've queued this for 4.0.

Thanks
