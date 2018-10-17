Received: from eggs.gnu.org ([2001:4830:134:3::10]:59875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCpko-0005MU-0d
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCpkl-0001Nj-NV
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:37:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCpkl-0001NT-GW
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:37:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-18-alex.bennee@linaro.org>
	<20181017120446.GF2530@work-vm>
Date: Wed, 17 Oct 2018 19:36:56 +0200
In-Reply-To: <20181017120446.GF2530@work-vm> (David Alan Gilbert's message of
	"Wed, 17 Oct 2018 13:04:47 +0100")
Message-ID: <87va60mq4n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 17/21] hmp: expose status of plugins to
 the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Pavel.Dovgaluk@ispras.ru, qemu-devel@nongnu.org, cota@braap.org, Stefan Hajnoczi <stefanha@redhat.com>, vilanova@ac.upc.edu

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Alex Benn=C3=A9e (alex.bennee@linaro.org) wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  hmp-commands-info.hx   | 17 +++++++++++++++++
>>  include/qemu/plugins.h |  1 +
>>  monitor.c              | 14 ++++++++++++++
>>  trace/plugins.c        | 15 +++++++++++++++
>>  4 files changed, 47 insertions(+)
>
> I'm OK with this; although it's worth thinking about whether this should
> be available via qmp, but it is just for debug/tracing.

Standard operating procedure for adding HMP commands without a QMP
equivalent: have the commit message explain why the QMP equivalent isn't
useful.

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
