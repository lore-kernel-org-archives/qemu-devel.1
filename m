Received: from eggs.gnu.org ([209.51.188.92]:58541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghUAd-0002jb-AM
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghUAV-0006qH-PN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:50:24 -0500
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-3-git-send-email-thuth@redhat.com>
	<f1d83216-d9a8-605b-d87b-be6b96f42557@redhat.com>
	<c965133d-f26d-3dba-81ed-1c87038e9b35@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <696b3151-3b6d-ce61-2189-e9876e2155b8@redhat.com>
Date: Thu, 10 Jan 2019 07:50:09 +0100
MIME-Version: 1.0
In-Reply-To: <c965133d-f26d-3dba-81ed-1c87038e9b35@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] configure: Force the C standard to
 gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2019-01-09 22:26, Paolo Bonzini wrote:
> On 09/01/19 19:10, Philippe Mathieu-Daud=C3=A9 wrote:
>> Using '-std=3Dgnu++98' for g++ v4.8 looks like a good compromise to th=
e
>> issues Daniel mentioned (still 'experimental').
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> C++11 has many new features that almost make it an entirely different
> language (the main being rvalue references, and type inference with aut=
o
> and decltype).  If it works for GCC 4.8, I would prefer using that
> instead of g++98.

I think we can revisit that setting when we really want to introduce
code that needs it. Currently it does not seem to be necessary, so that
does not justify to use an "experimental" feature of GCC 4.8, I guess.

 Thomas
