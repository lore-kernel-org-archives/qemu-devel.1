Received: from eggs.gnu.org ([2001:4830:134:3::10]:50922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkm4k-000173-ED
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkm4g-0003rB-Nz
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:01:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkm4g-0003r3-JS
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 04:01:38 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180731155043.GK29167@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 31 Jul 2018 16:50:43 +0100")
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
	<1533026124-6740-3-git-send-email-liq3ea@gmail.com>
	<20180731112906.GG2476@work-vm> <87o9enqx4s.fsf@trasno.org>
	<20180731155043.GK29167@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 01 Aug 2018 10:01:31 +0200
Message-ID: <878t5q4isk.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Add qmp command for
 migrate_set_max_cpu_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, crosthwaite.peter@gmail.com, Li Qiang <liq3ea@gmail.com>, armbru@redhat.com, qemu-devel@nongnu.org, liqiang02@corp.netease.com, pbonzini@redhat.com, hzliuyingdong@corp.netease.com, rth@twiddle.net

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Tue, Jul 31, 2018 at 04:48:35PM +0200, Juan Quintela wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> > * Li Qiang (liq3ea@gmail.com) wrote:
>> >> The default max cpu throttle is 99, this is too big that may
>> >> influence the guest loads. Add a qmp to config it can make it
>> >> more flexible.
>> >>=20
>> >> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>> >
>> > This should be done as a migration parameter rather than a new command.
>> > For example, follow the cpu-throttle-increment parameter; and this
>> > should work just like it.
>>=20
>> I was about to comment this one.
>>=20
>> migrate_set_downtime, migrate_set_speed, migrate-set-cache-size,
>> query-migrate-cache-size are marked as deprecated.  Any way that we
>> could have make more clear that one should use
>> migrate_set/get_parameter/capability?
>
> Where are they marked as deprecated ?

##
# @migrate_set_downtime:
#
# Set maximum tolerated downtime for migration.
#
# @value: maximum downtime in seconds
#
# Returns: nothing on success
#
# Notes: This command is deprecated in favor of 'migrate-set-parameters'
#
# Since: 0.14.0
#
# Example:
#
# -> { "execute": "migrate_set_downtime", "arguments": { "value": 0.1 } }
# <- { "return": {} }
#
##
{ 'command': 'migrate_set_downtime', 'data': {'value': 'number'} }

Notes: field.  Clearly we need to do still more work there.
Will change the texi, thanks.

>
> They're not included in our official list of deprecated features, so per
> our deprecation policy, they are still considered supported.
>
>   https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features
>
> To deprecate something it needs to be added to qemu-deprecated.texi, and
> ideally also made to print a message to stderr when triggered.

will send a patch to add to the texi and the print to stderr, thanks.
