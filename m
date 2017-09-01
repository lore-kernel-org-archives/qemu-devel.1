Received: from eggs.gnu.org ([2001:4830:134:3::10]:48007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnjQ4-0000tK-8c
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnjPz-0003k5-LI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnjPz-0003iw-EY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:43:19 -0400
Date: Fri, 1 Sep 2017 12:43:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170901124302.3c7c27c6.cohuck@redhat.com>
In-Reply-To: <96af6291-8427-89c8-c644-a3d82c3240c8@redhat.com>
References: <1504190408-11143-1-git-send-email-thuth@redhat.com>
	<612870af-f8a4-039c-3e97-7590388b9e77@redhat.com>
	<87o9qudbsk.fsf@dusky.pond.sub.org>
	<96af6291-8427-89c8-c644-a3d82c3240c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tests: Enable the drive_del test also
 on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Michael S Tsirkin <mst@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

On Fri, 1 Sep 2017 12:39:49 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 01.09.2017 11:10, Markus Armbruster wrote:
> > David Hildenbrand <david@redhat.com> writes:
> >   
> >>>  static void test_drive_del_device_del(void)
> >>>  {
> >>> +    char *args;
> >>> +
> >>>      /* Start with a drive used by a device that unplugs instantaneously */
> >>> -    qtest_start("-drive if=none,id=drive0,file=null-co://,format=raw"
> >>> -                " -device virtio-scsi-pci"
> >>> -                " -device scsi-hd,drive=drive0,id=dev0");
> >>> +    args = g_strdup_printf("-drive if=none,id=drive0,file=null-co://,format=raw"
> >>> +                           " -device virtio-scsi-%s"
> >>> +                           " -device scsi-hd,drive=drive0,id=dev0",  
> >>
> >> Would look better with the spaces at the end of the previous line (so
> >> all "-device" are aligned), but just my taste.  
> > 
> > The -device *are* aligned, but I get what you mean.
> > 
> > The advantage of leading rather than trailing space is that the
> > intention "this is still the same string" is locally obvious both at the
> > first part's end (no comma) and at the second part's beginning (leading
> > space).  
> 
> I don't mind either way, but in this case, I think I'd prefer to keep
> the original formatting with the space at the beginning, for the
> following two reasons:
> 
> - The first line is already hitting the 80 columns limit, and I want to
>   avoid complaints from checkpatch.pl
> - The original author formatted it that way.

I'd keep it that way as well.
