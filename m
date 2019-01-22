Received: from eggs.gnu.org ([209.51.188.92]:41296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gloeL-0002dP-AT
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gloXV-0007At-Vs
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:23:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gloXT-00078N-0O
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:23:56 -0500
References: <20190121181030.2112-1-philmd@redhat.com>
	<76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
	<5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
	<c52c29be-f285-2e5c-24ce-352c284e2b58@redhat.com>
	<20190122000452-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <407faf62-ad6e-c846-05aa-beafb3da0c14@redhat.com>
Date: Tue, 22 Jan 2019 06:23:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190122000452-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>

On 2019-01-22 06:05, Michael S. Tsirkin wrote:
> On Tue, Jan 22, 2019 at 05:28:12AM +0100, Thomas Huth wrote:
>> On 2019-01-21 20:46, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 1/21/19 8:22 PM, Eric Blake wrote:
>>>> On 1/21/19 12:10 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> Commit 2974e916df8 introduced the VirtioNetRscChain structure which
>>>>> refer to a VirtIONet, declared later, thus required VirtIONet typed=
ef
>>>>> to be declarated forward.
>>>>
>>>> s/be declarated forward/use a forward declaration/
>>>
>>> Thanks Eric.
>>>
>>> Thomas, do you mind fixing this if you take this patch?
>>
>> No problem, just fixed it while picking up the patch.
>=20
> I'm not sure why it's going through that tree but sure go ahead.

Sorry, I certainly don't want to step on your toes here. I just need
this patch to fix compilation with "-std=3Dgnu99" which is required for
the patch in my PULL request that enables this compiler flag there:

https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02695.html

> Sent Reviewed-by tag.

Thanks a lot!

 Thomas
