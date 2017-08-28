Received: from eggs.gnu.org ([2001:4830:134:3::10]:39667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmOVl-000570-Nm
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 14:11:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dmOVk-0006qj-Sg
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 14:11:45 -0400
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<20170828025706.GA18194@lemon.lan>
From: John Snow <jsnow@redhat.com>
Message-ID: <923084c5-f1a8-e361-2e4e-b635249a59be@redhat.com>
Date: Mon, 28 Aug 2017 14:11:24 -0400
MIME-Version: 1.0
In-Reply-To: <20170828025706.GA18194@lemon.lan>
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
To: Nir Soffer <nsoffer@redhat.com>, Yaniv Dary <ydary@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>



On 08/27/2017 10:57 PM, Fam Zheng wrote:
> On Fri, 08/25 15:44, Max Reitz wrote:
>> Well, OK.  The main argument against supporting anything but qcow2 is
>> "if you want features, use qcow2; and we are working on making qcow2 as
>> fast as possible."  I think that's a very good argument still.  At some
>> point I (and probably others, too) had the idea of making qcow2 files in
>> raw layout: 
> 
> 
> Yes! I think this idea makes a whole lot of sense, too. Metadata tables can be
> generated so old implementation can still use it.
> 
> Fam
> 
>> Have the data as a blob, just like a raw file, padded by
>> metadata around it.  An autoclear flag would specify that the qcow2 file
>> is in this format, and if so, you could simply access it like a raw file
>> and should have exactly the same speed as a raw file.  Maybe that would
>> solve this whole issue, too?

I wonder if this would be sufficient to alleviate the desire to use raw
files...

(Eh, well, realistically, someone's still always going to ask if they
can use various features with non-qcow2 files...)

Nir, Yaniv; any input?

(Context: We're debating how to add persistent bitmaps to raw files as I
was informed that RHV was 'asking about it.' Max is reminding me there
is a proposal for a style of QCOW2 that uses a raw layout for data,
mitigating or eliminating any performance hits related to the L2 cache.
What I am not aware of is why RHV would use raw files for any purpose.
Is it performance? Simplicity? Could RHV use a raw-layout qcow2?)

--js
