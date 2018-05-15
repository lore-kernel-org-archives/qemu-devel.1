Received: from eggs.gnu.org ([2001:4830:134:3::10]:41849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIcBV-0004bT-3j
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:48:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIcBP-0006kM-5t
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:48:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47932 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fIcBP-0006fI-1h
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:48:11 -0400
References: <1526284560-20266-1-git-send-email-jasowang@redhat.com>
	<1526284560-20266-3-git-send-email-jasowang@redhat.com>
	<8e7bd278-eb4b-a142-2f57-7481a165ac3f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f58252a7-9f43-785c-be1b-1314823bccff@redhat.com>
Date: Tue, 15 May 2018 17:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <8e7bd278-eb4b-a142-2f57-7481a165ac3f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/4] net: Remove the deprecated "vlan"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On 15.05.2018 17:10, Eric Blake wrote:
> On 05/14/2018 02:55 AM, Jason Wang wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> It's been marked as deprecated since QEMU v2.9.0, so that should have
>> been enough time for everybody to either just drop unnecessary "vlan=3D=
0"
>> parameters, to switch to the modern -device + -netdev syntax for
>> connecting
>> guest NICs with host network backends, or to switch to the "hubport"
>> netdev
>> in case hubs are really wanted instead.
>>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/658904
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>=20
>> @@ -499,10 +497,11 @@
>> =C2=A0 # @opts: device type specific properties (legacy)
>> =C2=A0 #
>> =C2=A0 # Since: 1.2
>> +#
>> +# 'vlan' - removed with 2.12
>=20
> Shouldn't this be 2.13?

Oh man, yes, of course. Stefan already found that while reviewing my
patches (v3), but apparently I forgot to update it in the final v4 :-(
Sorry for that.

> NetClientDriver
> 2.12: dropped 'dump'
> ...
> NetLegacy
> 2.13: dropped 'vlan'
>=20
> or the way we do it for QKeyCode:
>=20
> NetClientDriver
> dump: dropped in 2.12
> ...
> NetLegacy
> vlan: dropped in 2.13

I think I slightly prefer the latter variant.

> As this is already in a pull request, and as NetClientDriver also needs
> a cleanup, that can be a followup patch.

The pull request has already been merged. I'll send a followup patch...

 Thomas
