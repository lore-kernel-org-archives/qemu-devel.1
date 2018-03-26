Received: from eggs.gnu.org ([2001:4830:134:3::10]:39170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f0Ngd-0005Bm-1H
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f0NgX-0001Th-DX
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:41:03 -0400
References: <20180322161226.29796-1-lvivier@redhat.com>
	<20180322161226.29796-3-lvivier@redhat.com>
	<51925b27-09cc-1c3e-674c-d80b423f92c8@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0fb14423-fc9d-3dd9-c63e-45fc3c0d6797@redhat.com>
Date: Mon, 26 Mar 2018 10:40:42 +0200
MIME-Version: 1.0
In-Reply-To: <51925b27-09cc-1c3e-674c-d80b423f92c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>

On 23/03/2018 21:50, Eric Blake wrote:
> On 03/22/2018 11:12 AM, Laurent Vivier wrote:
>> Re-run Coccinelle patch
>> scripts/coccinelle/error_propagate_null.cocci
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>> =C2=A0 io/channel-websock.c | 4 +---
>> =C2=A0 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>=20
> Misses an offender in numa.c, why?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06382.html
>=20

No, error_report_err() doesn't check if  err is NULL, we must check
before calling it.

Thanks,
Laurent
