Received: from eggs.gnu.org ([2001:4830:134:3::10]:40002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fDnnV-0007DE-5V
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fDnnR-00070v-4L
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:11:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fDnnQ-00070e-T9
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:11:33 -0400
Date: Wed, 2 May 2018 17:11:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180502091128.GB15438@lemon.usersys.redhat.com>
References: <20180316062822.15425-1-famz@redhat.com>
	<20180316062822.15425-2-famz@redhat.com>
	<20180501204110.t2suo47pgiktopsa@var.youpi.perso.aquilenet.fr>
	<20180502072859.GA15438@lemon.usersys.redhat.com>
	<363615e0-22b3-6fca-c90a-2a6ce205c609@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363615e0-22b3-6fca-c90a-2a6ce205c609@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On Wed, 05/02 09:44, Thomas Huth wrote:
> On 02.05.2018 09:29, Fam Zheng wrote:
> > On Tue, 05/01 22:41, Samuel Thibault wrote:
> >> Hello,
> >>
> >> I'm sorry I didn't find the time to have a look at it before.
> >>
> >> In general it looks good, just a few things:
> >>
> >> Samuel
> >>
> >> Fam Zheng, le ven. 16 mars 2018 14:28:21 +0800, a ecrit:
> >>> +        if (!net_hub_id_for_client(&s->nc, &vlan)) {
> >>
> >> That makes me think that IIUC, we shouldn't call them vlan, as mentioned
> >> in the recent vlan->hub renaming patches.
> >>
> >>> +{ 'struct': 'UsernetInfo',
> >>> +  'data': {
> >>> +    'id':              'str',
> >>> +    'vlan':            'int',
> >>
> >> and here as well, I guess.
> > 
> > OK, so rename this to hub? (I'm not familiar with the naming issue you pointed
> > out).
> 
> Yes, please rename it to "hub". See:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg05448.html

OK, thanks. I've posted v4 with it renamed.

Fam
