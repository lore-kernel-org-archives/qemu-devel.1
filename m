Received: from eggs.gnu.org ([2001:4830:134:3::10]:35791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cKPCR-0001gI-Ng
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cKPCM-00055e-AI
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:43:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1cKPCM-00054a-4J
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 07:43:46 -0500
Date: Fri, 23 Dec 2016 13:43:42 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20161223124342.xfw2beuf2rebewr6@eukaryote>
References: <585c0f59.2350c20a.e5711.e639@mx.google.com>
	<6897002c-9618-ba6b-3d42-8595bb13ac09@tuxfamily.org>
	<1742192160.5141190.1482484832078.JavaMail.zimbra@redhat.com>
	<b1eadebd-2585-94e9-447b-252c7654691a@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1eadebd-2585-94e9-447b-252c7654691a@tuxfamily.org>
Subject: [Qemu-devel] [Resolved -- false positive] Re: virus in colibriOS
 QEMU iso?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: vilcadam@gmail.com, qemu-devel@nongnu.org

On Fri, Dec 23, 2016 at 11:25:18AM +0100, Thomas Huth wrote:
> On 23.12.2016 10:20, Kashyap Chamarthy wrote:

[...]

> > Yes, I can confirm that I have downloaded the ISO from the 
> > official website -- it's a nightly build of their 
> > SVN revision 6766.
> 
> OK, as far as I can see, the issue comes from the setmbr.exe that is
> contained in the iso for writing the KolibriOS to an USB stick.
> According to http://board.kolibrios.org/viewtopic.php?t=2295 the report
> from Avira is a false positive (likely caused because the program tries
> to write to the MBR - which is also what some viruses / trojans are doing).

Phew, indeed it's a false positive.  To quote verbatim from the above
thread, for the record:

    "The program setmbr.exe modifies MBR of USB flash drives or
    (optionally) hard disks, to allow them load KolibriOS. Usually
    programs that modify MBR are viruses - that's why your [Avast]
    antivirus reported it."
 
> Anyway, since these Windows tools are not required for running
> KolibriOS in a VM, I've now removed them from the iso image and
> uploaded a new version to avoid future confusion:
> 
>  http://www.qemu-advent-calendar.org/2016/download/day09-v2.tar.xz

Thanks, Thomas, for the swift response while I was AFK.  Glad that we're
two people coordinating this. 

> If you've got some spare minutes, it would be great if you could give
> that new version another try to see whether the warning from Avira is
> now properly gone (I don't have a Windows here to test this on my own).

Yeah, I don't have Windows either to test.  But good that this is just a
false positive from an overly-paranoid tool.

-- 
/kashyap
