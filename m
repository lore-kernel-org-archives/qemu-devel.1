Received: from eggs.gnu.org ([2001:4830:134:3::10]:52596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKjhw-0006xu-Bd
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKjhq-0001Zu-Na
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:46:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gKjhq-0001Yk-HO
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:46:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180924092120.GA30163@caravaggio>
	<7c2b477e-bdac-c887-2510-82fe04acdcfe@redhat.com>
	<87b22690-e39c-3b46-dcb4-f6abc3213142@redhat.com>
	<CAFEAcA8yHb4MdtsJuXcswQp93DN5tSeN9dn8AWWL9se0DKvdcg@mail.gmail.com>
	<41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<20180926141518.GB9073@caravaggio>
	<3743752b-2670-1d89-2088-1e67122f5dcd@redhat.com>
	<CAAdtpL5WwF0x_cJt3=20WiJ5E2LJ-XfDCB8EOuzhEJkZsXszsw@mail.gmail.com>
	<9832950d-52e7-da47-d466-98746d3f7a83@redhat.com>
Date: Thu, 08 Nov 2018 13:46:39 +0100
In-Reply-To: <9832950d-52e7-da47-d466-98746d3f7a83@redhat.com> (Paolo
	Bonzini's message of "Thu, 8 Nov 2018 10:56:09 +0100")
Message-ID: <87va57n3dc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, QEMU Developers <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 08/11/2018 09:46, Philippe Mathieu-Daud=C3=A9 wrote:
>>=20
>>     Almost; if there's a conflict between the decision from "depends on"=
 and
>>     "select" says, it's an error.=C2=A0 (Likewise if there's a conflict =
between
>>     default-configs/ on one side, and "depends on"/"select" on the other=
).
>>=20
>>     This is different between kernel Kconfig and minikconf in my git rep=
o.
>>     The difference is because the Kconfig documentation warns against the
>>     surprising effects of "select" blindly enabling the target symbol;
>>     making minikconf stricter avoids those surprises.
>>=20
>>=20
>> So can we rename your tool Qconfig?
>
> Haha, that's up to whoever finishes the work. :)

There's your chance to leave your mark on QEMU!  SamConfig has a nice
ring to it, doesn't it?  ;-P
