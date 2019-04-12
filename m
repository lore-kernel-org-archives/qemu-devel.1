Received: from eggs.gnu.org ([209.51.188.92]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hF1OW-0003Ag-OF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hF1OV-0002iI-NG
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:59:24 -0400
References: <20190412152619.23542-1-thuth@redhat.com>
	<CAFEAcA9kXdUH3vkGLfEe+CFuD=S9XFEaWGNETre7gYOx5epFpQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d2fc749-e6ac-7646-8e37-3399d42b6822@redhat.com>
Date: Fri, 12 Apr 2019 20:59:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9kXdUH3vkGLfEe+CFuD=S9XFEaWGNETre7gYOx5epFpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/nseries: Deprecate the n800
 and n810 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On 12/04/2019 18.02, Peter Maydell wrote:
> On Fri, 12 Apr 2019 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>>
>> These machines depend on the deprecated bluetooth subsystem. In case w=
e
>> finally decide to remove the bluetooth subsystem, we likely need to
>> remove the n800 and n810 machines, too, so mark them now as deprecated=
.
>=20
> ...we could just remove the bluetooth devices from the boards?

Maybe we could. But do we really want to spent time to work on boards
that likely nobody uses anymore? Or do you know anybody using it?
(at least Guenter does not seem to use it, according to his list, see
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06125.html )

 Thomas
