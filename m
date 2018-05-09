Received: from eggs.gnu.org ([2001:4830:134:3::10]:39889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGHN7-0007fA-Us
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fGHN4-00009A-BI
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:10:37 -0400
References: <1525840700-30635-1-git-send-email-thuth@redhat.com>
	<f0a24157-3aa9-4b51-8870-e83407e85697@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c91c4ff7-85d8-3605-7890-779abebea6fd@redhat.com>
Date: Wed, 9 May 2018 07:10:21 +0200
MIME-Version: 1.0
In-Reply-To: <f0a24157-3aa9-4b51-8870-e83407e85697@amsat.org>
Content-Type: text/plain; charset=utf-8
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 09.05.2018 07:02, Philippe Mathieu-Daud=C3=A9 wrote:
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

Right ... but what do you do if you just want to fix something in the
generic comments of that file? Who's then responsible for picking up the
patch? ... well, updates to comments could maybe go through
qemu-trivial, too, so I'm also fine if we do not list trace-events in
MAINTAINERS. I'll leave this up to Stefan to decide.

 Thomas
