Received: from eggs.gnu.org ([2001:4830:134:3::10]:50475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fDmS5-0003Hy-1C
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fDmS1-00006Y-Qt
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:45:24 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:48682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fDmS1-00005I-KL
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:45:21 -0400
Date: Wed, 2 May 2018 09:45:17 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180502074517.lcohz6sqgbspzp62@var.youpi.perso.aquilenet.fr>
References: <20180316062822.15425-1-famz@redhat.com>
	<20180316062822.15425-2-famz@redhat.com>
	<20180501204110.t2suo47pgiktopsa@var.youpi.perso.aquilenet.fr>
	<20180502072859.GA15438@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502072859.GA15438@lemon.usersys.redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Fam Zheng, le mer. 02 mai 2018 15:29:36 +0800, a ecrit:
> On Tue, 05/01 22:41, Samuel Thibault wrote:
> > I'm sorry I didn't find the time to have a look at it before.
> > 
> > In general it looks good, just a few things:
> > 
> > Samuel
> > 
> > Fam Zheng, le ven. 16 mars 2018 14:28:21 +0800, a ecrit:
> > > +        if (!net_hub_id_for_client(&s->nc, &vlan)) {
> > 
> > That makes me think that IIUC, we shouldn't call them vlan, as mentioned
> > in the recent vlan->hub renaming patches.
> > 
> > > +{ 'struct': 'UsernetInfo',
> > > +  'data': {
> > > +    'id':              'str',
> > > +    'vlan':            'int',
> > 
> > and here as well, I guess.
> 
> OK, so rename this to hub? (I'm not familiar with the naming issue you pointed
> out).

I am not either :)

Please check with the thread

http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg02126.html

Samuel
