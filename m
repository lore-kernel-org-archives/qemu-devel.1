Received: from eggs.gnu.org ([2001:4830:134:3::10]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1dKldE-0002eA-Ix
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1dKldA-00019A-Gt
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:13:16 -0400
Received: from mta01.ornl.gov ([128.219.177.137]:6402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1dKldA-00018l-61
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:13:12 -0400
From: "Nutaro, James J." <nutarojj@ornl.gov>
Date: Tue, 13 Jun 2017 13:13:06 +0000
Message-ID: <1497359587814.46408@ornl.gov>
References: <1487097476-14259-1-git-send-email-nutarojj@ornl.gov>,
	<20170602144233.GA4868@flamenco>
In-Reply-To: <20170602144233.GA4868@flamenco>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH V8] qqq: module for synchronizing with a
 simulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>

Thanks for the review Emilio. =0A=
=0A=
>> Isn't this a KVM-only feature though? I don't see calls to qqq_sync()=0A=
>> anywhere but from kvm-all.c, but maybe I'm missing something.=0A=
=0A=
There is another call in the timer callback in qqq.c that gets invoked when=
 using =0A=
the -icount mode.=0A=
=0A=
>> Also, a few more comments:=0A=
=0A=
>> - Why "qqq" as the name for this feature? I fail to see any=0A=
>>  connection between the name and the feature.=0A=
=0A=
There was a similar package called qbox, and I got stuck thinking of a name=
. =0A=
So I somewhat unimaginatively just stuttered on the q. I'm open to a better=
=0A=
name.=0A=
=0A=
>> If Windows users ever wanted this feature, would we have to=0A=
>>  change the user-facing API (i.e. the -qqq parameter)?=0A=
=0A=
It will (or should) ignore the -qqq option on Windows. But I'll double chec=
k that.=0A=
=0A=
>> As is, isn't the code Unix-only rather than Linux-only?=0A=
=0A=
Yes, Unix-only. You are correct.=0A=
=0A=
Jim=0A=
________________________________________=0A=
From: Emilio G. Cota <cota@braap.org>=0A=
Sent: Friday, June 02, 2017 10:42 AM=0A=
To: Nutaro, James J.=0A=
Cc: qemu-devel@nongnu.org; pbonzini@redhat.com=0A=
Subject: Re: [Qemu-devel] [PATCH V8] qqq: module for synchronizing with a s=
imulation=0A=
=0A=
On Tue, Feb 14, 2017 at 13:37:56 -0500, James J. Nutaro wrote:=0A=
> This patch adds an interface for pacing the execution of QEMU to match an=
 external=0A=
> simulation clock. Its aim is to permit QEMU to be used as a module within=
 a=0A=
> larger simulation system.=0A=
(snip)=0A=
> +++ b/docs/simulation-sync.txt=0A=
> @@ -0,0 +1,59 @@=0A=
> +=3D Synchronizing the virtual clock with an external source =3D=0A=
> +=0A=
> +QEMU has a protocol for synchronizing its virtual clock=0A=
> +with the clock of a simulator in which QEMU is embedded=0A=
> +as a component. This options is enabled with the -qqq=0A=
> +argument, and it should generally be accompanied by the=0A=
> +following additional command line arguments:=0A=
> +=0A=
> +-icount 1,sleep=3Doff -rtc clock=3Dvm=0A=
> +  or=0A=
> +-enable-kvm -rtc clock=3Dvm=0A=
=0A=
Isn't this a KVM-only feature though? I don't see calls to qqq_sync()=0A=
anywhere but from kvm-all.c, but maybe I'm missing something.=0A=
=0A=
Also, a few more comments:=0A=
=0A=
- Why "qqq" as the name for this feature? I fail to see any=0A=
  connection between the name and the feature.=0A=
=0A=
- If Windows users ever wanted this feature, would we have to=0A=
  change the user-facing API (i.e. the -qqq parameter)?=0A=
=0A=
- As is, isn't the code Unix-only rather than Linux-only?=0A=
=0A=
Thanks,=0A=
=0A=
                Emilio=0A=
=0A=
