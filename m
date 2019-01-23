Received: from eggs.gnu.org ([209.51.188.92]:53810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmFBK-0000L1-Aj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmFBI-0007Vj-16
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:50:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmFBE-0007SS-Vk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:50:47 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
Date: Wed, 23 Jan 2019 10:50:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190123093657.GC27270@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, Kamil Rytarowski <kamil@netbsd.org>

On 2019-01-23 10:36, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 23, 2019 at 09:27:48AM +0100, Thomas Huth wrote:
>> On 2019-01-23 09:00, Gerd Hoffmann wrote:
>>>
>>> This is RfC because we might look at the ordering.  On linux we proba=
bly
>>> want prefer alsa over oss.
>> Yes, please! I've run into the trap a couple of times already: OSS
>> headers were available, but these days the OSS compatibility kernel
>> modules are not loaded anymore by default. So you compile QEMU with OS=
S
>> support and then wonder why you do not get any audio output at all...
>>
>> IMHO we should put OSS as last item in the list on Linux nowadays.
>=20
> Given our targetted platform list[1], are there even any platforms
> where we would *not* have alsa, but still have OSS ?  If not, then
> we could just drop the OSS driver entirely on the ground that it is
> obsolete.

We likely could drop OSS on Linux, but it is still required on FreeBSD
and NetBSD, isn't it? So unless we can drop it there, too, we can also
simply keep it as last option in the list on Linux as well.

 Thomas
