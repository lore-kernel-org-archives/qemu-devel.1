Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eHdm0-00025O-PR
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:45:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eHdlw-0007yB-Pz
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:45:40 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eHdlw-0007wo-IQ
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 17:45:36 -0500
Date: Wed, 22 Nov 2017 17:45:32 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171122224532.GA7731@flamenco>
References: <20171122084157.11480-1-quintela@redhat.com>
	<757102c5-41ad-8fe7-03f0-255e27ad43f3@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <757102c5-41ad-8fe7-03f0-255e27ad43f3@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Wed, Nov 22, 2017 at 09:32:04 -0300, Philippe Mathieu-Daudé wrote:
> On 11/22/2017 05:41 AM, Juan Quintela wrote:
> > This commit started use tb_unlock() and tlb_set_dirty() on non TCG
> > code.  Add the function as stubs.
> > 
> > commit 27266271977c5a30f2f7d493e042be1897827bdd
> > Author: Peter Maydell <peter.maydell@linaro.org>
> > Date:   Mon Nov 20 18:08:27 2017 +0000
> > 
> >     exec.c: Factor out before/after actions for notdirty memory writes
> >     ....
> > 
> 
> Maybe pasting the sha-1 is enough "Since 272662719 those stubs are missing".

Paolo's "git whatis" alias comes to mind:
  https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg00972.html

		E.
