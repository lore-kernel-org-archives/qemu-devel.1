Received: from eggs.gnu.org ([2001:4830:134:3::10]:57277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOYl-0005J2-RK
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fGOYi-0003TO-OV
	for qemu-devel@nongnu.org; Wed, 09 May 2018 08:51:07 -0400
References: <1525840700-30635-1-git-send-email-thuth@redhat.com>
	<f0a24157-3aa9-4b51-8870-e83407e85697@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <19e850ef-5384-280b-8d22-c9a776ccbc20@redhat.com>
Date: Wed, 9 May 2018 07:51:03 -0500
MIME-Version: 1.0
In-Reply-To: <f0a24157-3aa9-4b51-8870-e83407e85697@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add trace-events and
 qemu-option-trace.texi to tracing section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 05/09/2018 12:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 05/09/2018 01:38 AM, Thomas Huth wrote:
>> The "trace-events" and "qemu-option-trace.texi" files in the top direc=
tory
>> are currently "unmaintained" according to scripts/get_maintainer.pl. T=
hey
>> obviously belong to the Tracing section, so add an entry for them ther=
e.
>=20
> I agree qemu-option-trace.texi belongs to the Tracing section,
> however I think trace-events is not specific to Tracing but belongs to
> everybody maintaining a C file in the top directory... Since they'll
> need to modify this file.

I'd rather hear Stefan's opinion before outright nixing the addition of=20
trace-events to his section - personally, I think any patch touching a=20
trace-events is fair game for review by the tracing tree, even if it=20
ends up going in through another tree.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
