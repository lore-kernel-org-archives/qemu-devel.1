Received: from eggs.gnu.org ([2001:4830:134:3::10]:45321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJfGa-0002Xs-T0
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eJfGX-0004bH-R0
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 07:45:36 -0500
Date: Tue, 28 Nov 2017 13:45:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171128134528.699488bf.cohuck@redhat.com>
In-Reply-To: <d007f7af-f15e-105c-7859-13b7141cf260@redhat.com>
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-5-git-send-email-walling@linux.vnet.ibm.com>
	<d007f7af-f15e-105c-7859-13b7141cf260@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 4/5] s390-ccw: interactive
 boot menu for eckd dasd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Collin L. Walling" <walling@linux.vnet.ibm.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue, 28 Nov 2017 13:36:38 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 27.11.2017 21:55, Collin L. Walling wrote:

> > +static int zipl_boot_menu(block_number_t s1b_block_nr)
> > +{
> > +    void *stage2_data, *menu_offset;
> > +
> > +    read_stage2(s1b_block_nr, &stage2_data);
> > +    menu_offset = stage2_data;
> > +
> > +    /* Menu banner starts with "zIPL" */
> > +    while (menu_offset < stage2_data + STAGE2_MAX_SIZE - 4) {
> > +        if (magic_match(menu_offset, ZIPL_MAGIC_EBCDIC)) {
> > +            return menu_get_zipl_boot_index(menu_offset);
> > +        }
> > +        menu_offset++;
> > +    }
> > +
> > +    panic("\n! No menu data found !\n");  
> 
> Maybe remove the initial exclamation mark?

It does match the other panics in the code, though.

> 
> > +    /* should not reach here */
> > +    return 0;
> > +}  
