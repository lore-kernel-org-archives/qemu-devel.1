Received: from eggs.gnu.org ([2001:4830:134:3::10]:39455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cv9HK-0002z4-OS
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 17:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1cv9HF-0003c0-MK
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 17:12:46 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1cv9HF-0003bp-HD
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 17:12:41 -0400
Received: by mail-qk0-x243.google.com with SMTP id k139so9804506qke.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 14:12:41 -0700 (PDT)
Date: Mon, 3 Apr 2017 17:12:34 -0400
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Message-ID: <20170403211234.GA31854@foober.ini.cmu.edu>
References: <1490978921-3782-1-git-send-email-gsomlo@gmail.com>
	<1490978921-3782-2-git-send-email-gsomlo@gmail.com>
	<bef9b06c-c29e-4259-96c1-88c0c5950c41@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bef9b06c-c29e-4259-96c1-88c0c5950c41@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v1 1/3] applesmc: cosmetic whitespace and
 indentation cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, agraf@suse.de, eshelton@pobox.com

On Mon, Apr 03, 2017 at 10:34:09AM -0300, Philippe Mathieu-Daudé wrote:
> Hi Gabriel,
> 
> On 03/31/2017 01:48 PM, Gabriel L. Somlo wrote:
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > ---
> >  hw/misc/applesmc.c | 100 +++++++++++++++++++++++++++--------------------------
> >  1 file changed, 51 insertions(+), 49 deletions(-)
> > 
> > diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> > index 77fab5b..986f2ac 100644
> > --- a/hw/misc/applesmc.c
> > +++ b/hw/misc/applesmc.c
> > @@ -39,24 +39,27 @@
> >  /* #define DEBUG_SMC */
> > 
> >  #define APPLESMC_DEFAULT_IOBASE        0x300
> > -/* data port used by Apple SMC */
> > -#define APPLESMC_DATA_PORT             0x0
> > -/* command/status port used by Apple SMC */
> > -#define APPLESMC_CMD_PORT              0x4
> > -#define APPLESMC_NR_PORTS              32
> > 
> > -#define APPLESMC_READ_CMD              0x10
> > -#define APPLESMC_WRITE_CMD             0x11
> > -#define APPLESMC_GET_KEY_BY_INDEX_CMD  0x12
> > -#define APPLESMC_GET_KEY_TYPE_CMD      0x13
> > +enum {
> > +    APPLESMC_DATA_PORT               = 0x00,
> > +    APPLESMC_CMD_PORT                = 0x04,
> > +    APPLESMC_NUM_PORTS               = 0x20,
> > +};
> > +
> > +enum {
> > +    APPLESMC_READ_CMD                = 0x10,
> > +    APPLESMC_WRITE_CMD               = 0x11,
> > +    APPLESMC_GET_KEY_BY_INDEX_CMD    = 0x12,
> > +    APPLESMC_GET_KEY_TYPE_CMD        = 0x13,
> > +};
> > 
> >  #ifdef DEBUG_SMC
> >  #define smc_debug(...) fprintf(stderr, "AppleSMC: " __VA_ARGS__)
> >  #else
> > -#define smc_debug(...) do { } while(0)
> > +#define smc_debug(...) do { } while (0)
> >  #endif
> > 
> > -static char default_osk[64] = "This is a dummy key. Enter the real key "
> > +static char default_osk[65] = "This is a dummy key. Enter the real key "
> 
> Here is more than a cosmetic change.

You're right, that was my mistake (should have left it 64.
> 
> Since this array is initialized you can declare it without specify the size:
> static char default_osk[] = ...

It's initialized to something that's not necessarily 64 characters, so
(I assume) the size specification is there to reserve the appropriate
amount of space, which is precisely 64 bytes.

> OSK0 + OSK1 is 64, why need an extra byte?

Right, I undid that part of the patch, will resubmit everything minus
that hunk as part of v2.

> Can yoy add some self-explanatory #define and use them later in this file:
> 
>     applesmc_add_key(s, "OSK0", 32, s->osk);
>     applesmc_add_key(s, "OSK1", 32, s->osk + 32);
> 
> and
> 
>     if (!s->osk || (strlen(s->osk) != 64)) {
>         fprintf(stderr, "WARNING: Using AppleSMC with invalid key\n");

Do I have to, now that I'm staying away from touching that bit in the
first place ? :)

The original patch Eric Shelton proposed (inspired by FakeSMC)
completely reworks how keys are initialized, adds write support (and
access permissions) for select keys, and generally implements a much
more complete emulation of the AppleSMC. Since this is just about
getting OS X to keep working, I figured I'd keep changes to a minimum.

Reworking key initialization, adding write support, etc. could
(should?) be part of a separate series, if we decide we want a more
realistically emulated AppleSMC. In that case, minimizing churn and
leaving things as-is in this particular case would be preferable.

Let me know what you think.

Thanks,
--Gabriel
 
> 
> >                                "using the -osk parameter";
> > 
> >  struct AppleSMCData {
> > @@ -77,12 +80,11 @@ struct AppleSMCState {
> >      uint32_t iobase;
> >      uint8_t cmd;
> >      uint8_t status;
> > -    uint8_t key[4];
> > +    char key[4];
> >      uint8_t read_pos;
> >      uint8_t data_len;
> >      uint8_t data_pos;
> >      uint8_t data[255];
> > -    uint8_t charactic[4];
> >      char *osk;
> >      QLIST_HEAD(, AppleSMCData) data_def;
> >  };
> > @@ -93,10 +95,10 @@ static void applesmc_io_cmd_write(void *opaque, hwaddr addr, uint64_t val,
> >      AppleSMCState *s = opaque;
> > 
> >      smc_debug("CMD Write B: %#x = %#x\n", addr, val);
> > -    switch(val) {
> > -        case APPLESMC_READ_CMD:
> > -            s->status = 0x0c;
> > -            break;
> > +    switch (val) {
> > +    case APPLESMC_READ_CMD:
> > +        s->status = 0x0c;
> > +        break;
> >      }
> >      s->cmd = val;
> >      s->read_pos = 0;
> > @@ -123,54 +125,54 @@ static void applesmc_io_data_write(void *opaque, hwaddr addr, uint64_t val,
> >      AppleSMCState *s = opaque;
> > 
> >      smc_debug("DATA Write B: %#x = %#x\n", addr, val);
> > -    switch(s->cmd) {
> > -        case APPLESMC_READ_CMD:
> > -            if(s->read_pos < 4) {
> > -                s->key[s->read_pos] = val;
> > -                s->status = 0x04;
> > -            } else if(s->read_pos == 4) {
> > -                s->data_len = val;
> > -                s->status = 0x05;
> > -                s->data_pos = 0;
> > -                smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
> > -                          s->key[1], s->key[2], s->key[3], val);
> > -                applesmc_fill_data(s);
> > -            }
> > -            s->read_pos++;
> > -            break;
> > +    switch (s->cmd) {
> > +    case APPLESMC_READ_CMD:
> > +        if (s->read_pos < 4) {
> > +            s->key[s->read_pos] = val;
> > +            s->status = 0x04;
> > +        } else if (s->read_pos == 4) {
> > +            s->data_len = val;
> > +            s->status = 0x05;
> > +            s->data_pos = 0;
> > +            smc_debug("Key = %c%c%c%c Len = %d\n", s->key[0],
> > +                      s->key[1], s->key[2], s->key[3], val);
> > +            applesmc_fill_data(s);
> > +        }
> > +        s->read_pos++;
> > +        break;
> >      }
> >  }
> > 
> > -static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr1,
> > -                                      unsigned size)
> > +static uint64_t applesmc_io_data_read(void *opaque, hwaddr addr, unsigned size)
> >  {
> >      AppleSMCState *s = opaque;
> >      uint8_t retval = 0;
> > 
> > -    switch(s->cmd) {
> > -        case APPLESMC_READ_CMD:
> > -            if(s->data_pos < s->data_len) {
> > -                retval = s->data[s->data_pos];
> > -                smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
> > -                          retval);
> > -                s->data_pos++;
> > -                if(s->data_pos == s->data_len) {
> > -                    s->status = 0x00;
> > -                    smc_debug("EOF\n");
> > -                } else
> > -                    s->status = 0x05;
> > +    switch (s->cmd) {
> > +    case APPLESMC_READ_CMD:
> > +        if (s->data_pos < s->data_len) {
> > +            retval = s->data[s->data_pos];
> > +            smc_debug("READ_DATA[%d] = %#hhx\n", s->data_pos,
> > +                      retval);
> > +            s->data_pos++;
> > +            if (s->data_pos == s->data_len) {
> > +                s->status = 0x00;
> > +                smc_debug("EOF\n");
> > +            } else {
> > +                s->status = 0x05;
> >              }
> > +        }
> >      }
> > -    smc_debug("DATA Read b: %#x = %#x\n", addr1, retval);
> > +    smc_debug("DATA Read b: %#x = %#x\n", addr, retval);
> > 
> >      return retval;
> >  }
> > 
> > -static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr1, unsigned size)
> > +static uint64_t applesmc_io_cmd_read(void *opaque, hwaddr addr, unsigned size)
> >  {
> >      AppleSMCState *s = opaque;
> > 
> > -    smc_debug("CMD Read B: %#x\n", addr1);
> > +    smc_debug("CMD Read B: %#x\n", addr);
> >      return s->status;
> >  }
> > 
> > 
