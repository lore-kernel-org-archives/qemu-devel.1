Received: from eggs.gnu.org ([209.51.188.92]:49602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0w9E-0001f5-OM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 17:33:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0w9B-000104-47
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 17:33:24 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <randrianasulu@gmail.com>)
	id 1h0w98-0000uh-Us
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 17:33:21 -0500
Received: by mail-pg1-x543.google.com with SMTP id j3so4075502pgm.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 14:33:17 -0800 (PST)
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Tue, 5 Mar 2019 01:29:44 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201903050129.45128.randrianasulu@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Misc MIPS fulong2e improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: amarkovic@wavecomp.com, balaton@eik.bme.hu, qemu-devel@nongnu.org

Actually compiled something!

root@slax:/dev/shm/pmon/zloader.2edev# qemu-system-mips64el -M fulong2e -cp=
u Loongson-2E -m 1G  -bios pmon.bin -nographic

PMON2000 MIPS Initializing. Standby...
ERRORPC=3D00000000 CONFIG=3D00030932
 PRID=3D00006302
DIMM read
read memory type
read number of rows
read blocks per ddrram
read number of sides
read width
00000002
No DIMM in slot 1
DIMM SIZE=3D10000000
dma: command ae not supported
sdcfg=3D2d9043ae
msize=3D10000000
Init SDRAM Done!
Sizing caches...
Init caches...
godson2 caches found
Init caches done, cfg =3D 00030932

Copy PMON to execute location...
  start =3D 0x81000000
  s0 =3D 0x3ec00000
a1050000
copy text section done.
Copy PMON to execute location done.
sp=3D80ffc000Uncompressing Bios........................OK,Booting Bios
=46REQ
=46REI
DONE
DEVI
ENVI
MAPV
in envinit
nvram=3Dbfc00000
unknow flash type
unknow flash type
Mfg  0, Id 60
NVRAM is invalid!
NVRAM@bfc00000
STDV
80100000:  memory between 82fff400-83000000  is already been allocated,heap=
 is already above this point
SBDD
686I
0x3f8=3Dff
P12PCIH
PCIS
PCIR
PCIW
NETI
RTCL
PCID
VGAI
No VGA PCI device available
in configure
mainbus0 (root)
localbus0 at mainbus0
pcibr0 at mainbus0
pci0 at pcibr0 bus 0
vendor/product: 0x1106/0x0686 (bridge, ISA) at pci0 dev 5 function 0 not co=
nfigured
pciide0 at pci0 dev 5 function 1 vendor/product: 0x1106/0x0571 (mass storag=
e, IDE): DMA (unsupported), ch 0 cfg to compat, ch 1 cfg to compat
cd0 at pciide0 channel 1cd attach drive=3D0
dv_xname cd0
vendor/product: 0x1106/0x3038 (serialbus, USB) at pci0 dev 5 function 2 not=
 configured
vendor/product: 0x1106/0x3038 (serialbus, USB) at pci0 dev 5 function 3 not=
 configured
vendor/product: 0x1106/0x3057 (bridge, miscellaneous) at pci0 dev 5 functio=
n 4 not configured
vendor/product: 0x1106/0x3058 (multimedia, audio) at pci0 dev 5 function 5 =
not configured
vendor/product: 0x1106/0x3068 (communications, miscellaneous) at pci0 dev 5=
 function 6 not configured
rtl0 at pci0 dev 7 function 0 vendor/product: 0x10ec/0x8139 (network, ether=
net)8139 iobase =3Dbfd04000
: generic poll, address 00:00:00:00:00:00
Config1
 100Mbps HALF-DUPLEX.
in if attach
out configure
Keyboard succesfully initialized.
devconfig done.
ifinit done.
domaininit done.
init_proc....
HSTI
SYMI
SBDE

Configuration [Bonito,EL,NET,IDE]
Version: PMON2000 2.1 (Bonito) #1: =C2=F2 =EC=E0=F0  5 00:02:06 MSK 2019 co=
mmit b6ef3b0253f1ba9be62d01b07f9900d16c66e38e Author: QiaoChong <qiaochong@=
loongson.cn> Date:   Tue Dec 28 09:59:01 2010 +0800 .
Supported loaders [srec, elf, bin]
Supported filesystems [net, fat, fs, disk, iso9660, socket, tty, ram]
This software may be redistributed under the BSD copyright.
Copyright 2000-2002, Opsycon AB, Sweden.
Copyright 2005, ICT CAS.
CPU GODSON2 @ 199.94 MHz / Bus @ 66.00 MHz
Memory size 256 MB (256 MB Low memory,   0 MB High memory) .
Primary Instruction cache size 64kb (32 line, 4 way)
Primary Data cache size 64kb (32 line, 4 way)
Secondary cache size 512kb

BEV1
BEV0
BEV in SR set to zero.
PMON> ls
Pmon    _ftext  etext   start
PMON> help
help: Command not found. Try 'h' for help!
PMON> h
                             Boot and Load
        boot  boot                                                         =
                  oload  load memory from hostport
        load  load file
                                MyCmds
     testnet  testnet rtl0 [recv|send|loop]                                =
                   cp0s  access cp0
         pcs  select pci dev function                                      =
                  disks  select disk
          d1  dump address byte                                            =
                     d2  dump address half world
          d4  dump address world                                           =
                     d8  dump address double word
          m1  modify address byte                                          =
                     m2  mofify address half world
          m4  modify address world                                         =
                     m8  modify address double word
      setvga  set vga_available                                            =
                 setkbd  set kbd_available
    setinput  set input_from_both                                          =
              setoutput  set output_to_both
     initkbd  kbd_initialize                                               =
                  cache  cache [0 1]
        loop  loopcmd count cmd...                                         =
                   Loop  loopcmd count cmd...
     testide  test ide dma                                                 =
               checksum  calculate checksum for a memory section
       fdisk  dump disk partation                                          =
               ifconfig  ifconig fx0 [up|down|remove|stat|setmac|readrom|se=
trom|addr [netmask]
        ifup  ifup fxp0                                                    =
                 ifdown  ifdown fxp0
      rtlist  rtlist                                                       =
                  rtdel  rtdel
       sleep  sleep ms                                                     =
                 sleep1  sleep1 s
      memcpy  mymemcpy src dst count                                       =
                    led  led n
       mycmp  mecmp s1 s2 len                                              =
                 mymore  mymore
      flashs  select flash for read/write                                  =
                  devcp  copy form src to dst
      xmodem  xmodem serial                                                =
                sysinfo  hardware test
        info  hardware test                                                =
                  newmt  new memory test
       setup  setup boot loader                                            =
                      |  run cmd and return 0
        test  hardware test                                                =
                 serial  hardware test
        pnps  select pnp ops for d1,m1                                     =
                dumpsis  dump sis registers
        i2cs  select i2c ops for d1,m1
                               Debugger
           c  continue execution                                           =
                      t  trace (single step)
          to  trace (step over)                                            =
                     db  delete break point(s)
           b  set break point(s)                                           =
                      g  start execution (go)
         sym  define symbol                                                =
                     ls  list symbols
           r  display/set register                                         =
                      l  list (disassemble) memory
          bt  stack backtrace
                                 Misc
       devls  list devices                                                 =
                  flush  flush caches
      reboot  reboot system                                                =
               poweroff  reboot system
        halt  reboot system                                                =
                  flash  program flash memory
          tr  transparent mode                                             =
                     rz  zmodem download
                                 Shell
        more  paginator                                                    =
                      h  on-line help
          sh  command shell                                                =
                   vers  print version info
        eval  evaluate and print result                                    =
                     hi  display command history
        date  get/set date and time                                        =
                  about  about PMON2000
                                Network
      ifaddr  Configure Network Interface                                  =
                   ping  ping remote host
                           grub like command
      initrd  load initrd/initramfs image
                                Memory
           m  modify memory                                                =
                      d  display memory
     compare  compare memory to memory                                     =
                   copy  copy memory to memory
        fill  fill memory                                                  =
                 search  search memory
          mt  simple memory test
                                  Pci
      pcicfg  pci config space                                             =
                pciscan  scan pci bus
                              Environment
         env  display variable                                             =
                    set  display/set variable
       unset  unset variable(s)                                            =
                   eset  edit variable
                                 rays
          bl  Load Boot menu from config file
                      RAYS Commands for PMON 2000
                                  fxp
  setmac_fxp  Set mac address into E100 eeprom                             =
            readrom_fxp  dump E100 eprom content
writerom_fxp  write E100 eprom content
                                 8139
      netdmp  8139 helper                                                  =
                    ifm  Set 8139 interface mode
      setmac  Set mac address into 8139 eeprom                             =
                readrom  dump rtl8139 eprom content
    writerom  write the whole rtl8139 eprom content
                                ATPsata
     atpsata  atp sata read write
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
PMON>
=2D-----------

using commit

commit b6ef3b0253f1ba9be62d01b07f9900d16c66e38e (HEAD -> 2010)
Author: QiaoChong <qiaochong@loongson.cn>
Date:   Tue Dec 28 09:59:01 2010 +0800

    enable ls232 demo boardd led.

    Signed-off-by: QiaoChong <qiaochong@loongson.cn>


from pmon git  directory

and config "2edev"

Ok, with modified 2edev I got output much like original prom:

qemu-system-mips64el -M fulong2e -cpu Loongson-2E -m 1G  -bios pmon.bin -no=
graphic

PMON2000 MIPS Initializing. Standby...
ERRORPC=3D00000000 CONFIG=3D00030932
 PRID=3D00006302
DIMM read
read memory type
read number of rows
read blocks per ddrram
read number of sides
read width
00000002
No DIMM in slot 1
DIMM SIZE=3D10000000
dma: command ae not supported
sdcfg=3D2d9043ae
msize=3D10000000
Init SDRAM Done!
Sizing caches...
Init caches...
godson2 caches found
Init caches done, cfg =3D 00030932

Copy PMON to execute location...
  start =3D 0x81000000
  s0 =3D 0x3ec00000
a1050000
copy text section done.
Copy PMON to execute location done.
sp=3D80ffc000Uncompressing Bios..........................OK,Booting Bios
=46REQ
=46REI
DONE
DEVI
ENVI
MAPV
in envinit
nvram=3Dbfc00000
unknow flash type
unknow flash type
Mfg  0, Id 60
NVRAM is invalid!
NVRAM@bfc00000
STDV
80100000:  memory between 82fff400-83000000  is already been allocated,heap=
 is already above this point
SBDD
686I
0x3f8=3Dff
P12PCIH
PCIS
PCIR
PCIW
NETI
RTCL
PCID
VGAI
No VGA PCI device available
VGAI
starting radeon init...


=2D-----------

configs are in pmon/Targets/Bonito2edev/conf
Modified conf:

at Bonito
# $Id: Bonito,v 1.1.1.1 2006/09/14 01:59:09 root Exp $ # #      GENERIC con=
figuration for Galileo EV64240 # #  This file is supposed to be included by=
 target file after #  endian has been defined.
#
machine         Bonito2edev        mips    # CPU Architecture, Platform
config          pmon

#
#  Define target endian
#
makeoptions     ENDIAN=3DEL               # Little endian version.


#include "conf/GENERIC_ALL"

#
# System Name and Target Name
#
option          SYSTYPE=3D"\"Bonito\""
option          TARGETNAME=3D"\"Bonito\""

#
# Platform options
#
option          BONITOEL
option      DEVBD2E
option          MIPS
option          INET

select          mod_flash_amd           # AMD flash device programming
select          mod_flash_intel         # intel flash device programming
select          mod_flash_sst           # intel flash device programming
select          mod_debugger            # Debugging module
select          mod_symbols             # Symbol table handling
select          mod_s3load              # Srecord loading
#select         mod_fastload            # LSI Fastload
select          mod_elfload             # ELF loading

#
# Command selection. Selects pmon commands
#
select          cmd_newmt
select          cmd_setup
select          mod_display
select          cmd_about               # Display info about PMON
select          cmd_boot                # Boot wrapper
select          cmd_mycmd
select          cmd_xmodem
select          ramfiles
select          cmd_newmt
select          cmd_cache               # Cache enabling
#select         cmd_call                # Call a function command
select          cmd_date                # Time of day command
select          cmd_env                 # Full blown environment command set
select          cmd_flash               # Flash programming cmds
select          cmd_hist                # Command history
select          cmd_ifaddr              # Interface address command
select          cmd_l                   # Disassemble
select          cmd_mem                 # Memory manipulation commands
select          cmd_more                # More paginator
select          cmd_mt                  # Simple memory test command
select          cmd_misc                # Reboot & Flush etc.
#select         cmd_stty                # TTY setings command
select          cmd_tr                  # Host port-through command
select          cmd_devls               # Device list
select          cmd_set                 # As cmd_env but not req. cmd_hist
select          cmd_testdisk
select          cmd_test
select          pmon_zmodem_rz
#
select          cmd_shell               # Shell commands, vers, help, eval
#
#
# Platform options
#
select          mod_uart_ns16550        # Standard UART driver
#option         CONS_BAUD=3DB9600
option          CONS_BAUD=3DB115200
select          ext2
select          fatfs
select          mod_x86emu              # X86 emulation for VGA
option  MY40IO
#select         mod_x86emu_int10
select          mod_vgacon
option          NOPCINAMES              # Save some space for x86emu
#option         FASTBOOT
select      vt82c686        #via686a/b code

#
# Functional options.
#
option          NOSNOOP                 # Caches are no-snooping

#
# HAVE options. What tgt level provide
#
option          HAVE_TOD                # Time-Of-Day clock
option          HAVE_NVENV              #  Platform has non-volatile env mem
option          HAVE_LOGO               # Output splash logo
option          USE_SUPERIO_UART
#option         USE_LEGACY_RTC
#option         GODSONEV2A
#option         LINUX_PC
#option         LONGMENG
option          RADEON7000
#option         DEBUG_EMU_VGA
option          AUTOLOAD
#option         CONFIG_PCI0_LARGE_MEM
#option         CONFIG_PCI0_HUGE_MEM
#option         CONFIG_PCI0_GAINT_MEM
option          CONFIG_CACHE_64K_4WAY
option      NVRAM_IN_FLASH

#
#  Now the Machine specification
#
mainbus0        at root
localbus0       at mainbus0
#fd0         at mainbus0
pcibr*          at mainbus0
#pcibr1         at mainbus0
pci*            at pcibr?
#ppb*           at pci? dev ? function ?        # PCI-PCI bridges
#pci*           at ppb? bus ?

#### USB
#uhci*          at pci? dev ? function ?

#### SCSI support
#siop*          at pci? dev ? function ?        # Symbios/NCR 53c...
#scsibus*       at siop?
#sd*            at scsibus? target ? lun ?
#cd*            at scsibus? target ? lun ?

#### Networking Devices
#gt0            at localbus? base 4
#gt1            at localbus? base 5
#gt2            at localbus? base 6
# fxp normally only used for debugging (enable/disable both)
fxp*            at pci? dev ? function ?        # Intel 82559 Device
inphy*          at mii? phy ?                   # Intel 82555 PHYs
rtl*        at pci? dev ? function ?
#uhci*           at pci? dev ? function ?
ohci0            at pci? dev ? function ?
usb*             at usbbus ?
ohci1            at pci? dev ? function ?

select      mod_usb
select          mod_usb_storage
#select      mod_usb_uhci
select          mod_usb_ohci
select      mod_usb_kbd


#### IDE controllers
pciide*         at pci ? dev ? function ? flags 0x0000
atp*           at pci? dev ? function ?  #sata atp8620
sata*       at atp?
#### IDE hard drives
wd*             at pciide? channel ? drive ? flags 0x0000

#### Pseudo devices
pseudo-device   loop    1       # network loopback

ide_cd*         at pciide? channel ? drive ? flags 0x0001
select          iso9660
option IDECD
#option HAVE_NB_SERIAL
option USE_ENVMAC
#option LOOKLIKE_PC
#select cmd_lwdhcp
#select cmd_bootp
option WDC_NORESET
option FOR_GXEMUL
select fatfs
option FLOATINGPT
select gzip
option VIA686B_POWERFIXUP
option INPUT_FROM_BOTH
option OUTPUT_TO_BOTH
option PCI_IDSEL_VIA686B=3D17

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Original conf:

cat Bonito.orig
# $Id: Bonito,v 1.1.1.1 2006/09/14 01:59:09 root Exp $ # #      GENERIC con=
figuration for Galileo EV64240 # #  This file is supposed to be included by=
 target file after #  endian has been defined.
#
machine         Bonito2edev        mips    # CPU Architecture, Platform
config          pmon

#
#  Define target endian
#
makeoptions     ENDIAN=3DEL               # Little endian version.


#include "conf/GENERIC_ALL"

#
# System Name and Target Name
#
option          SYSTYPE=3D"\"Bonito\""
option          TARGETNAME=3D"\"Bonito\""

#
# Platform options
#
option          BONITOEL
option      DEVBD2E
option          MIPS
option          INET

select          mod_flash_amd           # AMD flash device programming
select          mod_flash_intel         # intel flash device programming
select          mod_flash_sst           # intel flash device programming
select          mod_debugger            # Debugging module
select          mod_symbols             # Symbol table handling
select          mod_s3load              # Srecord loading
#select         mod_fastload            # LSI Fastload
select          mod_elfload             # ELF loading

#
# Command selection. Selects pmon commands
#
select          cmd_newmt
select          cmd_setup
select          mod_display
select          cmd_about               # Display info about PMON
select          cmd_boot                # Boot wrapper
select          cmd_mycmd
select          cmd_xmodem
select          ramfiles
select          cmd_newmt
select          cmd_cache               # Cache enabling
#select         cmd_call                # Call a function command
select          cmd_date                # Time of day command
select          cmd_env                 # Full blown environment command set
select          cmd_flash               # Flash programming cmds
select          cmd_hist                # Command history
select          cmd_ifaddr              # Interface address command
select          cmd_l                   # Disassemble
select          cmd_mem                 # Memory manipulation commands
select          cmd_more                # More paginator
select          cmd_mt                  # Simple memory test command
select          cmd_misc                # Reboot & Flush etc.
#select         cmd_stty                # TTY setings command
select          cmd_tr                  # Host port-through command
select          cmd_devls               # Device list
select          cmd_set                 # As cmd_env but not req. cmd_hist
select          cmd_testdisk
select          cmd_test
select          pmon_zmodem_rz
#
select          cmd_shell               # Shell commands, vers, help, eval
#
#
# Platform options
#
select          mod_uart_ns16550        # Standard UART driver
#option         CONS_BAUD=3DB9600
option          CONS_BAUD=3DB115200
select          ext2
select          fatfs
select          mod_x86emu              # X86 emulation for VGA
option  MY40IO
#select         mod_x86emu_int10
select          mod_vgacon
option          NOPCINAMES              # Save some space for x86emu
#option         FASTBOOT
select      vt82c686        #via686a/b code

#
# Functional options.
#
option          NOSNOOP                 # Caches are no-snooping

#
# HAVE options. What tgt level provide
#
option          HAVE_TOD                # Time-Of-Day clock
option          HAVE_NVENV              #  Platform has non-volatile env mem
option          HAVE_LOGO               # Output splash logo
option          USE_SUPERIO_UART
#option         USE_LEGACY_RTC
#option         GODSONEV2A
#option         LINUX_PC
#option         LONGMENG
#option         RADEON7000
#option         DEBUG_EMU_VGA
option          AUTOLOAD
#option         CONFIG_PCI0_LARGE_MEM
#option         CONFIG_PCI0_HUGE_MEM
#option         CONFIG_PCI0_GAINT_MEM
option          CONFIG_CACHE_64K_4WAY
option      NVRAM_IN_FLASH

#
#  Now the Machine specification
#
mainbus0        at root
localbus0       at mainbus0
#fd0         at mainbus0
pcibr*          at mainbus0
#pcibr1         at mainbus0
pci*            at pcibr?
#ppb*           at pci? dev ? function ?        # PCI-PCI bridges
#pci*           at ppb? bus ?

#### USB
#uhci*          at pci? dev ? function ?

#### SCSI support
#siop*          at pci? dev ? function ?        # Symbios/NCR 53c...
#scsibus*       at siop?
#sd*            at scsibus? target ? lun ?
#cd*            at scsibus? target ? lun ?

#### Networking Devices
#gt0            at localbus? base 4
#gt1            at localbus? base 5
#gt2            at localbus? base 6
# fxp normally only used for debugging (enable/disable both)
fxp*            at pci? dev ? function ?        # Intel 82559 Device
inphy*          at mii? phy ?                   # Intel 82555 PHYs
rtl*        at pci? dev ? function ?
#uhci*           at pci? dev ? function ?
#ohci0           at pci? dev ? function ?
#usb*            at usbbus ?
#ohci1           at pci? dev ? function ?

#select      mod_usb
#select         mod_usb_storage
#select      mod_usb_uhci
#select                 mod_usb_ohci
#select      mod_usb_kbd


#### IDE controllers
pciide*         at pci ? dev ? function ? flags 0x0000
atp*           at pci? dev ? function ?  #sata atp8620
sata*       at atp?
#### IDE hard drives
wd*             at pciide? channel ? drive ? flags 0x0000

#### Pseudo devices
pseudo-device   loop    1       # network loopback

ide_cd*         at pciide? channel ? drive ? flags 0x0001
select          iso9660
option IDECD
#option HAVE_NB_SERIAL
option USE_ENVMAC
#option LOOKLIKE_PC
#select cmd_lwdhcp
#select cmd_bootp
option WDC_NORESET
option FOR_GXEMUL
select fatfs
option FLOATINGPT
select gzip
option VIA686B_POWERFIXUP
option INPUT_FROM_BOTH
option OUTPUT_TO_BOTH
option PCI_IDSEL_VIA686B=3D17


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

qemu output with original binary (pmon_2e.bin):

  emu-system-mips64el -M fulong2e -cpu Loongson-2E -m 1G  -bios /dev/shm/pm=
on_2e.bin -nographic

PMON2000 MIPS Initializing. Standby...
ERRORPC=3D00000000 CONFIG=3D00030932
 PRID=3D00006302
DIMM read
00000080
read memory type
read number of rows
read memory size per side
read blocks per ddrram
read number of sides
read width
DIMM SIZE=3D10000000
dma: command df not supported
sdcfg=3D3d9043df
msize=3D10000000
Init SDRAM Done!
Sizing caches...
Init caches...
godson2 caches found
Init caches done, cfg =3D 00030932

Copy PMON to execute location...
  start =3D 0x85000000
  s0 =3D 0x3ac00000
a5040000
copy text section done.
Copy PMON to execute location done.
sp=3D84ffc000Uncompressing Bios........................OK,Booting Bios
=46REQ
=46REI
DONE
TTYI
TTYD
ENVI
MAPV
Mfg  0, Id 60
STDV
80100000: heap is already above this point
SBDD
686I
0x3f8=3Dff
PPCIH
PCI bus 0 slot 5/0: reg 0x10 =3D 0x0
PCI bus 0 slot 5/0: reg 0x14 =3D 0x0
PCI bus 0 slot 5/0: reg 0x18 =3D 0x0
PCI bus 0 slot 5/0: reg 0x1c =3D 0x0
PCI bus 0 slot 5/0: reg 0x20 =3D 0x0
PCI bus 0 slot 5/0: reg 0x24 =3D 0x0
PCI bus 0 slot 5/1: reg 0x10 =3D 0x1f0
PCI bus 0 slot 5/1: reg 0x14 =3D 0x3f4
PCI bus 0 slot 5/1: reg 0x1c =3D 0x374
PCI bus 0 slot 5/1: reg 0x24 =3D 0x0
PCI bus 0 slot 5/2: reg 0x10 =3D 0x0
PCI bus 0 slot 5/2: reg 0x14 =3D 0x0
PCI bus 0 slot 5/2: reg 0x18 =3D 0x0
PCI bus 0 slot 5/2: reg 0x1c =3D 0x0
PCI bus 0 slot 5/2: reg 0x20 =3D 0xffffffe1
PCI bus 0 slot 5/2: reg 0x24 =3D 0x0
PCI bus 0 slot 5/3: reg 0x10 =3D 0x0
PCI bus 0 slot 5/3: reg 0x14 =3D 0x0
PCI bus 0 slot 5/3: reg 0x18 =3D 0x0
PCI bus 0 slot 5/3: reg 0x1c =3D 0x0
PCI bus 0 slot 5/3: reg 0x20 =3D 0xffffffe1
PCI bus 0 slot 5/3: reg 0x24 =3D 0x0
PCI bus 0 slot 5/4: reg 0x10 =3D 0x0
PCI bus 0 slot 5/4: reg 0x14 =3D 0x0
PCI bus 0 slot 5/4: reg 0x18 =3D 0x0
PCI bus 0 slot 5/4: reg 0x1c =3D 0x0
PCI bus 0 slot 5/4: reg 0x20 =3D 0x0
PCI bus 0 slot 5/4: reg 0x24 =3D 0x0
PCI bus 0 slot 5/5: reg 0x10 =3D 0x0
PCI bus 0 slot 5/5: reg 0x14 =3D 0x0
PCI bus 0 slot 5/5: reg 0x18 =3D 0x0
PCI bus 0 slot 5/5: reg 0x1c =3D 0x0
PCI bus 0 slot 5/5: reg 0x20 =3D 0x0
PCI bus 0 slot 5/5: reg 0x24 =3D 0x0
PCI bus 0 slot 5/6: reg 0x10 =3D 0x0
PCI bus 0 slot 5/6: reg 0x14 =3D 0x0
PCI bus 0 slot 5/6: reg 0x18 =3D 0x0
PCI bus 0 slot 5/6: reg 0x1c =3D 0x0
PCI bus 0 slot 5/6: reg 0x20 =3D 0x0
PCI bus 0 slot 5/6: reg 0x24 =3D 0x0
PCIS
PCIR
PCIW
PCI bus 0 slot 5/1: not enough PCI mem space (-496 requested)
PCI bus 0 slot 5/1: not enough PCI mem space (-880 requested)
PCI bus 0 slot 5/1: not enough PCI mem space (-1008 requested)
NETI
RTCL
PCID
VGAI
Default MODE_ID 2
starting radeon init...
QEMU 3.0.50 monitor - type 'help' for more information

so, they obviously output different things, but I think you can configure t=
hem,=20
will try to disable just radeon init and see now far it will boot

sorry for superlong mail!
