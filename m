Received: from eggs.gnu.org ([2001:4830:134:3::10]:58719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1f5ShU-0003lx-5D
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1f5ShQ-00050F-Ut
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:02:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1f5ShQ-0004yN-Q1
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C40EE82FC482
	for <qemu-devel@nongnu.org>; Mon,  9 Apr 2018 09:02:51 +0000 (UTC)
Date: Mon, 9 Apr 2018 11:02:44 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180409090244.GP9903@paraplu>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180307151836.GK20201@redhat.com>
	<20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
	<20180308101728.GG4718@redhat.com>
	<f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
	<85d1416c-c442-eaf2-c4a5-3308fd63de3a@redhat.com>
	<721a331e-0ba9-58e2-8659-81b725a0ddff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721a331e-0ba9-58e2-8659-81b725a0ddff@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com

On Fri, Apr 06, 2018 at 08:21:00PM +0200, Laszlo Ersek wrote:
> On 04/06/18 20:10, Eric Blake wrote:

[...]

> # key=value pairs also support Python or JSON object literal subset notations,
> # without spaces. Dictionaries/objects {} are supported as are arrays [].
> #
> #    example-command arg-name1={'key':'value','obj'={'prop':"value"}}
> #
> # Both JSON and Python formatting should work, including both styles of
> # string literal quotes. Both paradigms of literal values should work,
> # including null/true/false for JSON and None/True/False for Python.

A couple of examples of the the key-value pairs and using JSON dicts
with 'qmp-shell'.

Key-value pairs:

  (QEMU) blockdev-snapshot node=node-Base snapshot-file=./overlay1.qcow2 overlay=node-Overlay1
  [...]

A combination key-value pairs and JSON dicts:

   (QEMU) blockdev-add driver=qcow2 node-name=node-overlay1 file={"driver":"file","filename":"overlay1.qcow2"}
   [...]

> This looks awesome, because it should let me provide messy nested input
> (which I'll obviously compose in my $EDITOR and then paste it), and then
> the QMP shell will both validate and pretty print that. I'm going to try
> this.

A couple of notes when using the 'qmp-shell':

  - Assuming you started QEMU with: `[...] -qmp
    unix:/tmp/qmp-sock,server,nowait`, you might want to use the '-p'
    command-line option to prett-print the JSON:
    
        $ qmp-shell -v -p /tmp/qmp-sock

  - It also provides a persistent command history in a convenient file:
    '~/.qmp-shell_history'

-- 
/kashyap
