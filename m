Received: from eggs.gnu.org ([208.118.235.92]:38251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gcKGH-0008MK-5P
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 20:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <admin@grossmann-venter.com>) id 1gcKGG-0000vy-Gp
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 20:14:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Dec 2018 20:14:53 -0500
From: liebrecht@grossmann-venter.com
In-Reply-To: <665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
References: <b0d70556767952dc739454d074bdab52@grossmann-venter.com>
	<665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
Message-ID: <96b5e642f1641df04a2c3f8b5b12bd6a@grossmann-venter.com>
Subject: Re: [Qemu-devel] Qemu the right way.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Qemu-devel <qemu-devel-bounces+admin=grossmann-venter.com@nongnu.org>

On 2018-12-26 02:14, Thomas Huth wrote:

> 
>> 2) I need to at least have sound working from applications in the 
>> guest
>> with pulseaudio on the Debian host. Is it  possible ?
> 
> Should be possible. Run the configure script before compiling with
> 
>  --audio-drv-list=pa
> 
> and then make sure to give a soundcard to the guest (e.g. with the
> -soundhw option).
> 


I now move on to sound.

I could get sound working as you instructed. I chose to load all sound 
cards and see if I can find one that works.

Sound does work but it ios very intermittent, seemingly the same as what 
happens to the mouse as if there is a timeshare going on.

Any idea what that can be.

Please not that I am running AVLinux which has a real time kernel as I 
can remember. Maybe qemu has trouble with realtime kernels ? Or what can 
the reason be for the intermittent sound. Sound on for 2 seconds off for 
a seconds etc,
Note that I did not compile a new version yet and just used the deb 
version. I will do that now

Is the sound problems due to not following your advice below ? What does
--audio-drv-list=pa actually do  ???


For reference
My string now looks as follows.

qemu-system-x86_64 -soundhw all  -smp 4 -m 2048M -boot d -cdrom 
/dev/cdrom -drive format=raw,file=hd.img
