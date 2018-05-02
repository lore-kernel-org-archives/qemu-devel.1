Received: from eggs.gnu.org ([2001:4830:134:3::10]:46894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fDmD3-00039v-FA
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:29:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fDmD2-0007K1-L4
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:29:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fDmD2-0007IN-E7
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:29:52 -0400
Date: Wed, 2 May 2018 15:29:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180502072859.GA15438@lemon.usersys.redhat.com>
References: <20180316062822.15425-1-famz@redhat.com>
	<20180316062822.15425-2-famz@redhat.com>
	<20180501204110.t2suo47pgiktopsa@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501204110.t2suo47pgiktopsa@var.youpi.perso.aquilenet.fr>
Subject: Re: [Qemu-devel] [PATCH for-2.13 v3 1/2] slirp: Add "query-usernet"
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Tue, 05/01 22:41, Samuel Thibault wrote:
> Hello,
> 
> I'm sorry I didn't find the time to have a look at it before.
> 
> In general it looks good, just a few things:
> 
> Samuel
> 
> Fam Zheng, le ven. 16 mars 2018 14:28:21 +0800, a ecrit:
> > +        if (!net_hub_id_for_client(&s->nc, &vlan)) {
> 
> That makes me think that IIUC, we shouldn't call them vlan, as mentioned
> in the recent vlan->hub renaming patches.
> 
> > +{ 'struct': 'UsernetInfo',
> > +  'data': {
> > +    'id':              'str',
> > +    'vlan':            'int',
> 
> and here as well, I guess.

OK, so rename this to hub? (I'm not familiar with the naming issue you pointed
out).

> 
> > +void slirp_connection_info(Slirp *slirp, Monitor *mon)
> > +{
> > +    const char *state;
> > +    char buf[64];
> > +    UsernetInfo info = { };
> > +    UsernetConnectionList *cl;
> > +
> > +    monitor_printf(mon, "  Protocol[State]    FD  Source Address  Port   "
> > +                        "Dest. Address  Port RecvQ SendQ\n");
> > +
> > +    usernet_get_info(slirp, &info);
> 
> Mmm, I don't see the content of info being freed here?

You're right, will fix.

Fam
