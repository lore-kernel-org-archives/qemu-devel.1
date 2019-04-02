Received: from eggs.gnu.org ([209.51.188.92]:60953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBFdq-000281-Hp
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hBFTy-0003Vn-PT
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:13:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:42880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hBFIf-0000zh-02
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:01:45 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Tue, 2 Apr 2019 09:01:38 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060B1FCE@shsmsx102.ccr.corp.intel.com>
References: <20190326174510.13303-1-chen.zhang@intel.com>
	<87y34tgc7m.fsf@dusky.pond.sub.org>
	<9CFF81C0F6B98A43A459C9EDAD400D78060B1D99@shsmsx102.ccr.corp.intel.com>
	<87lg0sg5vz.fsf@dusky.pond.sub.org>
In-Reply-To: <87lg0sg5vz.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qapi/migration.json: Fix documentation
 issue about query_colo_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>, "Dr. David Alan
	Gilbert" <dgilbert@redhat.com>, Zhang Chen <zhangckid@gmail.com>



> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Tuesday, April 2, 2019 4:37 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: Markus Armbruster <armbru@redhat.com>; zhanghailiang
> <zhang.zhanghailiang@huawei.com>; Juan Quintela <quintela@redhat.com>;
> qemu-dev <qemu-devel@nongnu.org>; Dr. David Alan Gilbert
> <dgilbert@redhat.com>; Zhang Chen <zhangckid@gmail.com>
> Subject: Re: [Qemu-devel] [PATCH] qapi/migration.json: Fix documentation
> issue about query_colo_status
>=20
> "Zhang, Chen" <chen.zhang@intel.com> writes:
>=20
> >> -----Original Message-----
> >> From: Markus Armbruster [mailto:armbru@redhat.com]
> >> Sent: Tuesday, April 2, 2019 2:20 PM
> >> To: Zhang, Chen <chen.zhang@intel.com>
> >> Cc: Zhang Chen <zhangckid@gmail.com>; Dr. David Alan Gilbert
> >> <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>;
> >> zhanghailiang <zhang.zhanghailiang@huawei.com>; Eric Blake
> >> <eblake@redhat.com>; qemu- dev <qemu-devel@nongnu.org>; Zhang, Chen
> >> <chen.zhang@intel.com>
> >> Subject: Re: [Qemu-devel] [PATCH] qapi/migration.json: Fix
> >> documentation issue about query_colo_status
> >>
> >> Zhang Chen <chen.zhang@intel.com > writes:
> >>
> >> > From: Zhang Chen <chen.zhang@intel.com>
> >> >
> >> > The documentation with the wrong initial version number of
> >> > last_mode field, This patch just fix this issue.
> >> >
> >> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> >> > ---
> >> >  qapi/migration.json | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/qapi/migration.json b/qapi/migration.json index
> >> > cfde29acf8..798c6ac2df 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -1382,7 +1382,7 @@
> >> >  #
> >> >  # @last_mode: COLO last running mode. If COLO is running, this fiel=
d
> >> >  #             will return same like mode field, after failover we c=
an
> >> > -#             use this field to get last colo mode. (since 4.1)
> >> > +#             use this field to get last colo mode. (since 4.0)
> >> >  #
> >> >  # @reason: describes the reason for the COLO exit.
> >> >  #
> >>
> >> What's the excuse for spelling last_mode with '_' instead of '-'?
> >>
> >> Any objection to changing it to last-mode?
> >
> > No, I just found in migration.json have both '_' and  '-', for example
> "migrate_cancel" and "migrate-continue".
> > If you think we should use the '-' format in this migration.qapi file, =
I will send
> a patch to change all command format to the '-'.
>=20
> Quote docs/devel/qapi-code-gen.txt:
>=20
>     Command names, and member names within a type, should be all lower
>     case with words separated by a hyphen.  However, some existing older
>     commands and complex types use underscore; when extending such
>     expressions, consistency is preferred over blindly avoiding
>     underscore.
>=20
> The consistency argument doesn't apply here.
>=20
> I'd prefer to have this cleaned up, and I'd prefer to have it done in -rc=
2.  If I see
> a patch from you before I do my pull request, I'll use it, otherweise I'l=
l patch it
> myself.

Hi Markus,

I have sent a patch for this issue, please pick up it.
[PATCH] qapi/migration.json: Clean up for COLOStatus

Thanks
Zhang Chen
