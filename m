Received: from eggs.gnu.org ([2001:4830:134:3::10]:42788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnAUI-0005Fc-Bk
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnAUH-0005xR-IJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 17:25:26 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<20170828025706.GA18194@lemon.lan>
	<923084c5-f1a8-e361-2e4e-b635249a59be@redhat.com>
	<CACKMAy-nOFc40d2n2pQ-VYX7tjDBQS-AGT=SYcxrxSrDd6enTA@mail.gmail.com>
	<1491bc75-e1ee-b63b-a75b-6d5c39faab7c@redhat.com>
	<CACKMAy8QV8nFE2Awj1m49xcqB1=yXcQjmLKGRgY5-9AJ9ETgJA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d4c53113-0afd-4325-3cd3-9fd7cf3604b5@redhat.com>
Date: Wed, 30 Aug 2017 17:25:07 -0400
MIME-Version: 1.0
In-Reply-To: <CACKMAy8QV8nFE2Awj1m49xcqB1=yXcQjmLKGRgY5-9AJ9ETgJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Yaniv Lavi (Dary)" <ylavi@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: "Mureinik, Allon" <amureini@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Fam Zheng <famz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Tal Nisan <tnisan@redhat.com>



On 08/30/2017 08:58 AM, Yaniv Lavi (Dary) wrote:
> 
> 
> We had no reason to switch to anything else so far and I'm sure this
> option was not available when we started supporting raw format. 
>  
> 

Yeah, they don't exist yet...! I've looped you in to see if the proposal
being discussed would alleviate the need for bitmaps for "other formats"
if we can offer a "raw mode qcow2."

At the moment I am going to still try to add bitmaps to other formats
(through the use of a qcow2 wrapper) but it sounds like a raw-layout
qcow2 might provide some benefits too.

-js
